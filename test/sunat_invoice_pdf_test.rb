require 'test_helper'

class SunatInvoicePdfTest < Minitest::Test
  def setup
    provider = SunatInvoice::Provider.new(ruc: '2039201021',
                                          name: 'AWESOME BIZ')
    @invoice = SunatInvoice::Invoice.new(provider: provider)
  end

  def test_that_it_has_a_version_number
    refute_nil ::SunatInvoicePdf::VERSION
  end

  def test_it_does_include_generate_pdf
    assert SunatInvoice::XmlDocument.new.respond_to?('generate_pdf')
  end

  def test_generate_pdf
    pdf = @invoice.generate_pdf
    pdf.render_file "#{@invoice.document_name}.pdf"
  end
end
