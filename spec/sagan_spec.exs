defmodule SaganSpec do
  use ESpec, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  
  describe "create_document/2" do
    it "should create a document and return the body" do
      use_cassette "create_document", custom: true do
        doc = %{
          id: "foo",
          bar: "baz"
        }

        {:ok, resp} = Sagan.create_document("testDocs", doc)
        
        expect resp["id"]  |> to(eq "foo")
        expect resp["bar"] |> to(eq "baz")
        expect resp        |> to(have_key "_rid")
        expect resp        |> to(have_key "_self")
        expect resp        |> to(have_key "_etag")
        expect resp        |> to(have_key "_attachments")
        expect resp        |> to(have_key "_ts")
      end
    end
  end
end