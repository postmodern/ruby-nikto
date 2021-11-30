require 'spec_helper'
require 'nikto/xml/item'
require 'nokogiri'

describe Nikto::XML::Item do
  let(:fixtures_dir) { File.expand_path(File.join(__dir__,'..','fixtures')) }
  let(:path) { File.join(fixtures_dir,'nikto.xml') }
  let(:xml)  { File.read(path) }
  let(:doc)  { Nokogiri::XML(File.open(path)) }
  let(:node) { doc.at_xpath('/niktoscan/scandetails/item') }

  subject { described_class.new(node) }

  describe "#description" do
    subject { super().description }

    it "must return the inner text of the 'description' child element" do
      expect(subject).to eq(node.at_xpath('description').inner_text)
    end
  end

  describe "#uri" do
    subject { super().uri }

    it "must return the inner text of the 'uri' child element" do
      expect(subject).to eq(node.at_xpath('uri').inner_text)
    end
  end

  describe "#name_link" do
    subject { super().name_link }

    it "must return the inner text of the 'namelink' child element" do
      expect(subject).to eq(node.at_xpath('namelink').inner_text)
    end
  end

  describe "#ip_link" do
    subject { super().ip_link }

    it "must return the inner text of the 'iplink' child element" do
      expect(subject).to eq(node.at_xpath('iplink').inner_text)
    end
  end
end
