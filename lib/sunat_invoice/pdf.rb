require 'sunat_invoice_pdf/pdf_document'

module SunatInvoice
  module Pdf
    def generate_pdf
      SunatInvoicePdf::PdfDocument.new(self)
    end
  end
end
