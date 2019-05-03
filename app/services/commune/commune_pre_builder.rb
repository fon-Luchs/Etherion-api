class Commune::CommunePreBuilder
  def self.build(record)
    new(record).pre_build
  end

  def pre_build
    remove_commune_addiction! if @record.valid?
  end

  private

  def initialize(record)
    @record = record

    @user = record.creator
  end

  def remove_commune_addiction!
    com = CommuneUser.find_by(user: @user)

    com&.destroy
  end
end
