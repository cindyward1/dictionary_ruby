require "rspec"
require "term"

describe "Term" do

  before do
    Term.clear
  end

  it "starts with an empty list of terms" do
    Term.all.should eq []
  end

  it "creates a term with an input word and definition" do
    test_term = Term.new("House","A place where a person lives.")
    expect(test_term.words[0]).to eq "House"
    expect(test_term.definitions[0]).to eq "A place where a person lives."
  end

end
