require 'prawn'
require_relative 'locale'

module SunatInvoicePdf
  class PdfDocument < Prawn::Document
    def initialize(doc)
      super(page_size: "A6")
      text doc.provider.name
      print_address(doc.provider)
      text "RUC #{doc.provider.ruc}"

      text I18n.localize(doc.date, format: :long)

      text doc.document_number

      doc.lines.each do |line|
        text "#{line.desc} #{line.price}"
      end
      text "TOTAL #{doc.total}"
    end

    private

    def print_address(provider)
      text "#{provider.street} #{provider.zone}"
      text "#{provider.district}, #{provider.province}, #{provider.department}"
    end
  end
end
