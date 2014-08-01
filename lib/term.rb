class Term
  @@all_terms = []

  def Term.all
    @@all_terms
  end

  def Term.clear
    @@all_terms = []
  end

  def initialize (word,definition)
    @words = []
    @definitions = []
    @words << word
    @definitions << definition
  end

  def words
    @words
  end

  def definitions
    @definitions
  end

end
