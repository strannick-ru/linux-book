function Para(el)
    -- Check if the paragraph has any content
    if #el.content > 0 then
        -- Get the last element of the paragraph
        local last_elem = el.content[#el.content]
        
        -- Check if it's a string and ends with a colon
        if last_elem.t == "Str" and last_elem.text:sub(-1) == ":" then
            -- Append a raw LaTeX \nopagebreak command
            table.insert(el.content, pandoc.RawInline('latex', '\\nopagebreak'))
            return el
        end
    end
end
