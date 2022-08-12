class Shift < ApplicationRecord
  belongs_to :engineer
  belongs_to :available_hour

  def self.generate_shifts(structure)
    import(structure, validate: false)
  end
end
