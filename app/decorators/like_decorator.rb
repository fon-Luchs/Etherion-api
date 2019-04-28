class LikeDecorator < ApplicationDecorator
  delegate_all

  def as_json(*args)
    {
      kind: object.kind
    }
  end
end
