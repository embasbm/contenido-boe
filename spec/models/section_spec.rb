require 'rails_helper'

describe Section do
  before(:all) { @section = FactoryGirl.create(:section) }
  subject { @section }

  it { should respond_to(:name) }
  it { should respond_to(:number) }

  xit { is_expected.to be_embedded_in(:diary) }
  xit { is_expected.to embed_many(:departments) }

  it '#name should responde to type' do
    expect(@section.name).to be_a String
  end

  it '#number should responde to type' do
    expect(@section.number).to be_a String
  end
end
