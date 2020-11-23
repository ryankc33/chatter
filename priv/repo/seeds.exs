# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Chatter.Repo.insert!(%Chatter.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Chatter.Accounts.register_user(%{email: System.get_env("DEFAULT_USER_EMAIL"), password: System.get_env("DEFAULT_USER_PASSWORD")})
