import { application } from "./application"
import Autocomplete from "stimulus-autocomplete"

class BookAutocomplete extends Autocomplete {
  buildURL(query) {
    const url = new URL(this.urlValue, window.location.origin)

    const searchType = document.querySelector(
      '[name="search_type"]'
    )?.value || "title"

    url.searchParams.set("search_type", searchType)
    url.searchParams.set("q", query)

    return url.toString()
  }
}

application.register("autocomplete", BookAutocomplete)