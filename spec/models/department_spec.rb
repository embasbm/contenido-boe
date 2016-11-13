require 'rails_helper'

describe Department do
  before(:all) { @department = FactoryGirl.create(:department) }

  subject { @department }

  it { should respond_to(:name) }

  xit { is_expected.to be_embedded_in(:section).as_inverse_of(:department) }
  xit { is_expected.to embed_many(:epigraphs) }
  xit { is_expected.to embed_many(:items) }

  it '#name should responde to type' do
    expect(@department.name).to be_a String
  end
end
