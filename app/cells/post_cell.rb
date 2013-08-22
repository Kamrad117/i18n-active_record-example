class PostCell < Cell::Rails
  include CanCan::ControllerAdditions
  include Devise::Controllers::Helpers
  Devise::Controllers::Helpers.define_helpers(Devise::Mapping.new(:user, {}))

  def edit(opts)
    @post = Post.find(opts[:id])
    render
  end

  def index
    @post = Post.all
    render
  end

  def show(opts)
    @post = Post.find(opts[:id])
    render
  end

  def tabs
    render
  end

end
