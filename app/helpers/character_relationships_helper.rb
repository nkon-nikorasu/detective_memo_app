module CharacterRelationshipsHelper
  def escape_mermaid_label(text)
    text.to_s
        .gsub('"', "&quot;")
        .gsub("\n", " ")
        .gsub("\r", " ")
  end
end
