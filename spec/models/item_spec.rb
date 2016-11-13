require 'rails_helper'

describe Item do
  before(:all) { @item = FactoryGirl.create(:item) }

  subject { @item }

  it { should respond_to(:item_id) }
  it { should respond_to(:title) }
  it { should respond_to(:pdf_url) }

  xit { is_expected.to be_embedded_in(:epigraph) }
  xit { is_expected.to be_embedded_in(:department) }

  it '#item_id should responde to type' do
    expect(@item.item_id).to be_a String
  end

  it '#title should responde to type' do
    expect(@item.title).to be_a String
  end

  it '#pdf_url should responde to type' do
    expect(@item.pdf_url).to be_a String
  end
end
