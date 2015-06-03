module Gws::BaseFilter
  extend ActiveSupport::Concern
  include SS::BaseFilter

  included do
    before_action :set_cur_org
    before_action :set_group

    def current_group
      @cur_group
    end

    def current_organization
      @cur_org
    end

    private
      # Set the instance variable of `@cur_org`.
      # When a request path is `/..g123/schedule/plan/new`, `group` becomes
      # `123` and set `SS::Group` instance whose ID is 123 to `@cur_org`.
      def set_cur_org
        @cur_org = SS::Group.find params[:group]
        raise "404" unless @cur_org
      end

      # Set current user's group by `@cur_org`.
      def set_group
        cur_groups = @cur_user.groups.in(name: /^#{@cur_org.name}(\/|$)/)
        @cur_group = cur_groups.first # select one group
        raise "403" unless @cur_group
      end
  end

  # TODO Remove following codes because of dependencies each other
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
