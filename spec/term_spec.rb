require "rspec"
require "term"

describe "Term" do

  before do
    Term.clear
  end

  it "'all' starts with an empty list of terms" do
    expect(Term.all).to eq []
  end

  it "'new' creates a term with an input word and definition" do
    test_term = Term.new("House","A place where a person lives.")
    expect(test_term.word).to eq "House"
    expect(test_term.definitions[0]).to eq "A place where a person lives."
  end

  it "'term_add' adds the new term to the dictionary" do
    test_term = Term.new("House", "A place where a person lives.")
    test_term.term_add
    expect(Term.all[0].word).to eq "House"
    expect(Term.all[0].definitions[0]).to eq "A place where a person lives."
  end

  it "'term_delete' deletes the specified term from the dictionary" do
    test_term1 = Term.new("House", "A place where a person lives")
    test_term1.term_add
    test_term2 = Term.new("Car", "Something people drive")
    test_term2.term_add
    deleted_term = Term.term_delete(0)
    expect(Term.all).to eq [test_term2]
    expect(deleted_term).to eq test_term1
  end

  it "'term_sort' sorts the dictionary by word alphabetical order" do
    test_term1 = Term.new("House", "A place where a person lives")
    test_term1.term_add
    test_term2 = Term.new("Car", "Something people drive")
    test_term2.term_add
    Term.term_sort
    expect(Term.all).to eq [test_term2, test_term1]
  end

  it "'definition_add' adds a definition to the term" do
     test_term = Term.new("House", "A place where a person lives")
     test_term.definition_add("A place where laws go to die")
     expect(test_term.definitions).to eq ["A place where a person lives", "A place where laws go to die"]
  end

  it "'definition_edit' changes the definition of the term" do
    test_term = Term.new("House", "A place where a person lives")
    test_term.definition_edit(0, "A place where laws go to die")
    expect(test_term.definitions).to eq ["A place where laws go to die"]
  end

  it "'definition_delete' deletes a definition from the term" do
    test_term = Term.new("House", "A place where a person lives")
    test_term.definition_delete(0)
    expect(test_term.definitions).to eq []
  end
end
