# Knuth-Morris-Pratt string searching

# This function creates an array of integers indicating how many characters we can safely skip on a mismatch.
def kmpTable(word)
    length = word.length
    dfa = Array.new(length) # Deterministic finite automaton
    dfa[0] = -1
    dfa[1] = 0
    idx = 1

    while(idx < length)

        previous = dfa[idx]

        if previous == 0
            if word[idx] == word[0]
                dfa[idx+1] = 1
            else
                dfa[idx+1] = 0
            end
        elsif word[idx] == word[previous]
            dfa[idx+1] = previous + 1
        else
            dfa[idx+1] = 0
        end

        idx += 1;
    end
    return dfa
end

# Returns the index of the first occurance of the word
def kmpSearch(word, text)
    dfa = kmpTable(word)

    wordLength = word.length
    textLength = text.length

    wordOffset = 0
    textOffset = 0
    
    while(wordOffset + textOffset < textLength)
        # The characters match
        if(word[wordOffset] == text[wordOffset + textOffset])
            if(wordOffset == wordLength-1)
                # All characters match
                return textOffset
            else
                wordOffset += 1
            end
        else
            # No match. Using the dfa we might be able to skip
            # ahead a few more characters in the text.
            textOffset = textOffset + wordOffset - dfa[wordOffset]
            if dfa[wordOffset] > 1
                wordOffset = dfa[wordOffset]
            else
                wordOffset = 0
			end
        end
    end
    
    # No match
    return -1
end

# Returns an array of all occurances of the word
def kmpSearchAll(word, text)
    dfa = kmpTable(word)

    wordLength = word.length
    textLength = text.length

    wordOffset = 0
    textOffset = 0
    
    matches = []
    
    while(wordOffset + textOffset < textLength)
    
        if(word[wordOffset] == text[wordOffset + textOffset]	)
            # The characters match
            if(wordOffset == wordLength-1)
                # All characters match
                matches.push textOffset
                
                # Now look for the next occurance
                # Use the dfa to choose the the new text and word
                # offsets, potentially skipping ahead a bit.
                textOffset = textOffset + wordOffset - dfa[wordOffset]
                if dfa[wordOffset] > 1
                    wordOffset = dfa[wordOffset]
                else
                    wordOffset = 0
				end
            else
                wordOffset += 1
            end
        else
            # No match. Using the dfa we might be able to skip
            # ahead a few more characters in the text.
            textOffset = textOffset + wordOffset - dfa[wordOffset]
            if dfa[wordOffset] > 1
                wordOffset = dfa[wordOffset]
            else
                wordOffset = 0
			end
        end
    end
 
    return matches
end

testA = "kkmkmpkmpdDabc5sdlmnkmpop"
testB = ""
testC = "bc5sdbc5sdasdnkkblah"

loc = kmpSearch("kmp", testA)
puts "TestA : " + loc.to_s
loc = kmpSearch("kmp", testB)
puts "TestA : " + loc.to_s
loc = kmpSearch("kmp", testC)
puts "TestA : " + loc.to_s

matches = kmpSearchAll("kmp", testA)
puts "TestA : " + matches.length.to_s + "matches"
for i in matches
    puts "loc = #{i}"
end
matches = kmpSearchAll("kmp", testB)
puts "TestB : " + matches.length.to_s + "matches"
for i in matches
    puts "loc = #{i}"
end
matches = kmpSearchAll("kmp", testC)
puts "TestC : " + matches.length.to_s + "matches"
for i in matches
    puts "loc = #{i}"
end
