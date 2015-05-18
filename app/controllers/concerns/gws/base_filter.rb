module Gws::BaseFilter
  extend ActiveSupport::Concern
  include SS::BaseFilter

  included do
    before_action ->{ @cur_group = current_group }

    def current_group
      SS::Group.find params[:group]
    end

    # TODO 権限の処理もする(見られないグループなら403)
    #      cms/base_filter参考
  end
end
