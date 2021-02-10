function[subset,aqID,waveform] = VerifyingVar(subset, aqID, waveform)

    % Verifying variable subset
    if ~exist('subset', 'var')
        error("Subset not informed")
    else
        subset = char(subset);
        if ( (~strcmp(subset,'Synthetic'))&& ...
                (~strcmp(subset,'Natural'))&& ...
                (~strcmp(subset,'Sim_Ideal'))&& ...
                (~strcmp(subset,'Sim_Induct'))&& ...
                (~strcmp(subset,'Sim_Induct_Harmo'))&& ...
                (~strcmp(subset,'Sim_Induct_Harmo_SNR_10'))&& ...
                (~strcmp(subset,'Sim_Induct_Harmo_SNR_30'))&& ...
                (~strcmp(subset,'Sim_Induct_Harmo_SNR_60')) )
            error("Unexpected Dataset")
        end
    end

    %Verifying variables aqId and Waveform
    if ~exist('aqID', 'var')
        error("Acquisition ID not informed")
    end

    if exist('waveform', 'var')
        if ~isa(waveform,'double')
            error("Invalid variable type for waveform")
        end
    end

    % Verifying variable aqID
    aqID = char(aqID);
    if ( (aqID(1)~='1')&&(aqID(1)~='2')&&(aqID(1)~='3')&& ...
            (aqID(1)~='4')&&(aqID(1)~='5')&&(aqID(1)~='6')&& ...
            (aqID(1)~='7')&&(aqID(1)~='8') )
        error("Unexpected acquisition ID")
    end
    if( str2double(aqID(1)) ~= ((length(aqID)-1)/2) )
        error("Unexpected acquisition ID")
    end

    % Verifying variable waveform
    if ~isempty(waveform)
        if (waveform < 0) || (waveform > 15)
            error("Invalid waveform number")
        end
    end


end
