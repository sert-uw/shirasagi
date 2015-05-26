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

  def author?
    Board::Post.find(@item.id).user == @cur_user
  end

  def board_authority_check path
    unless author?
      redirect_to path, notice: t('board.no_authority')
    end
  end

  def topic_authority_check
    board_authority_check board_topics_path(@cur_group.id)
  end

  def comment_authority_check
    board_authority_check board_topic_path(@cur_group.id, @item.parent.id)
  end
end
