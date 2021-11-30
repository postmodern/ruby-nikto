require 'spec_helper'
require 'nikto/xml/statistics'
require 'nokogiri'

describe Nikto::XML::Statistics do
  let(:fixtures_dir) { File.expand_path(File.join(__dir__,'..','fixtures')) }
  let(:path) { File.join(fixtures_dir,'nikto.xml') }
  let(:xml)  { File.read(path) }
  let(:doc)  { Nokogiri::XML(File.open(path)) }
  let(:node) { doc.at_xpath('/niktoscan/scandetails/statistics') }

  subject { described_class.new(node) }

  describe "#elapsed" do
    subject { super().elapsed }

    it "must return the 'elapsed' attribute as an Integer" do
      expect(subject).to eq(node['elapsed'].to_i)
    end
  end

  describe "#items_found" do
    subject { super().items_found }

    it "must return the 'itemsfound' attribute as an Integer" do
      expect(subject).to eq(node['itemsfound'].to_i)
    end
  end

  describe "#items_tested" do
    subject { super().items_tested }

    it "must return the 'itemstested' attribute as an Integer" do
      expect(subject).to eq(node['itemstested'].to_i)
    end
  end

  describe "#end_time" do
    subject { super().end_time }

    it "must return the 'endtime' attribute as a Time object" do
      expect(subject).to eq(Time.parse(node['endtime']))
    end
  end
end
