class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    render plain: render_to_string(partial: 'form_new', layout: false, locals: { event: @event })
    #views/eventsディレクトリのなかに_form_new.html.erb というファイルを作り
    #そのファイルの中のhtmlコードを文字として返してくれます。
    #これはjsの時のコーディングで紐づいてくるのでいったん先に進みます。
  end

  def create
    @event = Event.new(params_event)
    if @event.save
      respond_to do |format|
        format.html { redirect_to root_path } 
        format.js  #create.js.erbを探してその中の処理を実行する
      end
    else
      respond_to do |format|
        format.js {render partial: "error" }
        #登録にエラーが起きたときはerror.js.erbを実行する
      end
    end
  end


  def params_event
      params.require(:event).permit(:title, :start, :end)
  end
end
