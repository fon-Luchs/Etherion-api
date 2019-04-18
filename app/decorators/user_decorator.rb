class UserDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    if context[:profile]
      {
        id: object.id,
        email: object.email,
        nickname: object.nickname,
        login: object.login,
        ads: [],
        readers: [],
        readables: [],
        letters: [],
        commune: '',
        polit_rate: 0
      }

    elsif context[:user_show]
      {
        id: object.id,
        email: object.email,
        nickname: object.nickname,
        login: object.login,
        ads: [],
        readers: [],
        readables: [],
        commune: ''
      }

    elsif context[:user_index]
      {
        id: object.id,
        nickname: object.nickname
      }
    end
  end
end
