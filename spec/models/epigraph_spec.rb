require 'rails_helper'

describe Epigraph do
  before(:all) { @epigraph = FactoryGirl.create(:epigraph) }

  subject { @epigraph }

  it { should respond_to(:name) }

  xit { is_expected.to be_embedded_in(:department) }
  xit { is_expected.to embed_many(:items) }

  it '#name should responde to type' do
    expect(@epigraph.name).to be_a String
  end

end
