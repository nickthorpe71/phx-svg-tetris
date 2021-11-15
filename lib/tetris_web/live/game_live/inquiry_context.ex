defmodule TetrisWeb.GameLive.InquiryContext do
  def get_inquiries_per_month(params) do
    # year =
    #   Decimal.new(params["year"])
    #   |> Decimal.to_float()

    # query =
    #   Repo.all(
    #     from m in Inquiry,
    #       where: fragment("date_part('year', ?)", m.inserted_at) == ^year,
    #       group_by: fragment("month"),
    #       select: %{
    #         month: fragment("to_char(?, 'Mon') as month", m.inserted_at),
    #         count: count(m.id)
    #       }
    #   )
  end
end
