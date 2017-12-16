# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sunat_invoice_pdf/version'

Gem::Specification.new do |spec|
  spec.name          = "sunat_invoice_pdf"
  spec.version       = SunatInvoicePdf::VERSION
  spec.authors       = ["César Carruitero"]
  spec.email         = ["ccarruitero@protonmail.com"]

  spec.summary       = "Pdf support for SunatInvoice"
  spec.description   = "Allows get a pdf ready to print from SunatInvoice documents"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
