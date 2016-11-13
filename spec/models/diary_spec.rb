require 'rails_helper'

describe Diary do

  before(:all) { @diary = FactoryGirl.create(:diary) }

  subject { @diary }

  it { should respond_to(:date_pub) }
  it { should respond_to(:nbo) }
  it { should respond_to(:pdf_url) }

  xit { should embed_many(:sections) }

  it '#date_pub sould respond to type' do
    expect(@diary.date_pub).to be_a String
  end

  it '#nbo sould respond to type' do
    expect(@diary.nbo).to be_an String
  end

  it '#pdf_url sould respond to type' do
    expect(@diary.pdf_url).to be_a String
  end
end
