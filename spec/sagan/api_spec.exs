defmodule Sagan.APISpec do
  use ESpec, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Mock

  alias Sagan.API

  describe "post/2" do
    it "should post to Cosmos DB using the body and url provided" do
      use_cassette "create_document", custom: true do
        assert {:ok, resp} = API.post("dbs/test/colls/testDocs/docs", %{id: "foo", bar: "baz"})

        expect resp["id"]  |> to(eq "foo")
        expect resp["bar"] |> to(eq "baz")
        expect resp        |> to(have_key "_rid")
        expect resp        |> to(have_key "_self")
        expect resp        |> to(have_key "_etag")
        expect resp        |> to(have_key "_attachments")
        expect resp        |> to(have_key "_ts")
      end
    end

    it "should return ok and the message when status code comes back other than 2XX" do
      use_cassette "create_document_fail", custom: true do
        assert {:ok, resp} = API.post("dbs/test/colls/testDocs/docs", %{id: "foo", bar: "baz"})
        
        expect resp["code"]     |> to(eq "Conflict")
        expect resp["message"]  |> to(be_binary())
      end
    end

    it "should error when HTTPoison fails" do
      with_mock HTTPoison, [post: fn(_, _, _, _) -> {:error, %HTTPoison.Error{reason: "fail"}} end] do
        assert {:error, "fail"} = API.post("dbs/test/colls/testDocs/docs", %{id: "foo", bar: "baz"})
      end
    end

    it "should error for any other case" do
      with_mock HTTPoison, [post: fn(_, _, _, _) -> "not a valid option" end] do
        assert {:error, "Unknown error occured during api call."} = API.post("dbs/test/colls/testDocs/docs", %{id: "foo", bar: "baz"})
      end
    end
  end

  describe "get/1" do
    it "should get from Cosmos DB using the url provided"
    it "should error when status code comes back other than 2XX"
    it "should error when HTTPoison fails"
    it "should error for any other case"
  end
end