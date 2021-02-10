function[n_t, numLoads] = NumberOfTraces(subset, aqID)

    numLoads = extractBefore(aqID, 2);

    switch subset
        case 'Natural'
            n_t = 0;
        case 'Synthetic'
            n_t = (0:15);
        otherwise
            aqID = char(aqID);
            
            switch numLoads
                case '1'
                    n_t = (0:2);
                case '2'
                    n_t = (0:8);
                otherwise
                    n_t = (0:4);
            end
    end


end