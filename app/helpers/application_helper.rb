module ApplicationHelper

  def active_current_tab(tab)
    params[:tab] == tab ? "bg-secondary" : ""
  end

  def stations_list(source)
    Station.order(:name).collect {|station| [station.name, station.id]}.unshift(["Select #{source ? "source" : "destination"} station", ""])
  end

  def row_color_for_booking(status)
    {"confirmed" => "table-success", "waiting" => "table-warning", "canceled" => "table-danger"}.dig(status)
  end

  def confirmed_or_cancel(status)
    status == Ticket::CANCELED ? "border border-danger" : ""
  end

  def alert_bar(nature)
    render partial: "shared/alert", locals: {nature: nature, message: notice}
  end

end
