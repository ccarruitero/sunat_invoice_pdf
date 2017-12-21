require 'prawn'
require 'prawn/table'
require_relative 'locale'

module SunatInvoicePdf
  class PdfDocument < Prawn::Document
    OPERATIONS = {
      '1001' => 'operaciones gravadas',
      '1002' => 'operaciones inafectas',
      '1003' => 'operaciones exoneradas',
      '1004' => 'Operaciones gratuitas',
      '1005' => 'Sub total de venta',
      '2001' => 'Percepciones',
      '2002' => 'Retenciones',
      '2003' => 'Detracciones',
      '2004' => 'Bonificaciones',
      '2005' => 'Total descuentos'
    }.freeze

    def initialize(doc)
      super(page_size: "A6")
      text doc.provider.name
      print_address(doc.provider)
      text "RUC #{doc.provider.ruc}"

      text I18n.localize(doc.date, format: :long)

      text doc.document_number

      rows = []
      doc.lines.each do |line|
        row = []
        row << line.description
        row << line.quantity
        row << amount_content(line.bi_value)
        rows << row
      end

      hash_to_row(doc.sale_totals, rows)
      hash_to_row(doc.taxes_totals, rows)
      total_row('TOTAL', doc.total, rows)

      options = { cell_style: { borders: [] }}
      table(rows, options)
    end

    private

    def get_label(code)
      OPERATIONS[code]&.upcase || code
    end

    def amount_content(amount)
      { content: amount.to_s, align: :right }
    end

    def hash_to_row(hash, data)
      hash.each do |key, value|
        label = get_label(key.to_s.upcase)
        total_row(label, value, data)
      end
    end

    def total_row(label, total_amount, data)
      data << [{ content: label, colspan: 2}, amount_content(total_amount)]
    end

    def print_address(provider)
      text "#{provider.street} #{provider.zone}"
      text "#{provider.district}, #{provider.province}, #{provider.department}"
    end
  end
end
