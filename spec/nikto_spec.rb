require 'nikto/version'

require 'spec_helper'

describe Nikto do
  it "should have a VERSION constant" do
    Nikto.const_defined?('VERSION').should == true
  end
end
