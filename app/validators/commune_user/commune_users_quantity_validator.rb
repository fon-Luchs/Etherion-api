class CommuneUser::CommuneUsersQuantityValidator < ActiveModel::Validator
  def validate(record)
    if record.user
      record.errors.add :commune_user, 'Number of users exceeded' if record.commune.users.count >= 50
    end
  end
end
