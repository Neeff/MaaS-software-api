class Shift < ApplicationRecord
  belongs_to :engineer
  belongs_to :available_hour

  default_scope { where(active: true) }

  def self.generate_shifts(structure)
    import(structure, validate: false)
  end
end
