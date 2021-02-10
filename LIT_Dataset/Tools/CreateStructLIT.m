function CreateStructLIT(subset,aqID,waveform,file_offset_in_loadset)

%  CreateStructLIT
%   Author: Bruna Molinari, Douglas Renaux
%   Modified by Filipe Chagas (filipe.ferraz0@gmail.com)

%
%   Creates a struct with acquisition data in 'Out' folder
%
%   Params:
%   1] subset: specifies the dataset by typing its name as:
%   'Natural', 'Synthetic', 'Sim_Ideal', 'Sim_Induct',
%   'Sim_Induct_Harmo', 'Sim_Induct_Harmo_SNR_10',
%   'Sim_Induct_Harmo_SNR_30' or 'Sim_Induct_Harmo_SNR_60'.
%
%   2] aqID: name of the acquisition to be read
%
%   3] waveform: It's a integer number from 0 to 15. 

%% 1 - Structures with the description of loads and acquisition sequence

    acquisition_desc = [
        struct('id','1A0','name','Microwave Standby',                         'path','1\1A0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1B0','name','LED Lamp',                                  'path','1\1B0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1C0','name','CRT Monitor Standby',                       'path','1\1C0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1D0','name','LED Panel',                                 'path','1\1D0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1E0','name','Soldering Smoke Extractor',                 'path','1\1E0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1F0','name','LED monitor Standby',                       'path','1\1F0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1G0','name','Phone Charger for ASUS X008D at 53%',       'path','1\1G0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1H0','name','Soldering Station',                         'path','1\1H0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1I0','name','Phone Charger for Moto E2 at 68%',          'path','1\1I0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1J0','name','Universal Charger for Yoga 520 at 24%',     'path','1\1J0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1K0','name','3 Speed Fan at highest speed',              'path','1\1K0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1L0','name','Resistor',                                  'path','1\1L0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1M0','name','AC Adapter Charger for Sony Vaio at 90%',   'path','1\1M0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1N0','name','Incandescent Lamp',                         'path','1\1N0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1O0','name','2 Speed Impact Drill at lower speed',       'path','1\1O0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1P0','name','Soldering Smoke Extractor',                 'path','1\1P0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1Q0','name','Oil Heater at lower power',                 'path','1\1Q0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1R0','name','Oil Heater at medium power',                'path','1\1R0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1S0','name','17 liters Microwave',                       'path','1\1S0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1T0','name','Fan Heater at maximum power',               'path','1\1T0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1U0','name','Hair Dryer at fan speed 1 and heat level 1','path','1\1U0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1V0','name','Hair Dryer at fan speed 2 and heat level 1','path','1\1V0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1W0','name','Hair Dryer at fan speed 1 and heat level 1','path','1\1W0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1X0','name','Hair Dryer at fan speed 1 and heat level 2','path','1\1X0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1Y0','name','Hair Dryer at fan speed 1 and heat level 1','path','1\1Y0', 'procedure','2s off, 15s on, 13s off');
        struct('id','1Z0','name','Hair Dryer at fan speed 2 and heat level 1','path','1\1Z0', 'procedure','2s off, 15s on, 13s off');
        struct('id','2A0B0','name','Microwave Standby then LED Lamp',                                        'path','2\2A0B0', 'procedure','2s off, 5s load A on, 10s load A and B on, 4s load B on, 9s off');
        struct('id','2A0H0','name','Microwave Standby then Soldering Station',                               'path','2\2A0H0', 'procedure','2s off, 5s load A on, 10s load A and H on, 4s load H on, 9s off');
        struct('id','2A0L0','name','Microwave Standby then Resistor',                                        'path','2\2A0L0', 'procedure','2s off, 5s load A on, 10s load A and L on, 4s load L on, 9s off');
        struct('id','2A0M0','name','Microwave Standby then AC Adapter Charger for Sony Vaio at 92%',         'path','2\2A0M0', 'procedure','2s off, 5s load A on, 10s load A and M on, 4s load M on, 9s off');
        struct('id','2A0N0','name','Microwave Standby then Incandescent Lamp',                               'path','2\2A0N0', 'procedure','2s off, 5s load A on, 10s load A and N on, 4s load N on, 9s off');
        struct('id','2A0Q0','name','Microwave Standby then Oil Heater at lower power',                       'path','2\2A0Q0', 'procedure','2s off, 5s load A on, 10s load A and Q on, 4s load Q on, 9s off');
        struct('id','2B0A0','name','LED Lamp then Microwave Standby',                                        'path','2\2B0A0', 'procedure','2s off, 5s load B on, 10s load B and A on, 4s load A on, 9s off');
        struct('id','2B0H0','name','LED Lamp then Soldering Station',                                        'path','2\2B0H0', 'procedure','2s off, 5s load B on, 10s load B and H on, 4s load H on, 9s off');
        struct('id','2B0L0','name','LED Lamp then Resistor',                                                 'path','2\2B0L0', 'procedure','2s off, 5s load B on, 10s load B and L on, 4s load L on, 9s off');
        struct('id','2B0M0','name','LED Lamp then AC Adapter Charger for Sony Vaio at 85%',                  'path','2\2B0M0', 'procedure','2s off, 5s load B on, 10s load B and M on, 4s load M on, 9s off');
        struct('id','2B0N0','name','LED Lamp then Incandescent Lamp',                                        'path','2\2B0N0', 'procedure','2s off, 5s load B on, 10s load B and N on, 4s load N on, 9s off');
        struct('id','2B0Q0','name','LED Lamp then Oil Heater at lower power',                                'path','2\2B0Q0', 'procedure','2s off, 5s load B on, 10s load B and Q on, 4s load Q on, 9s off');
        struct('id','2H0A0','name','Soldering Station then Microwave Standby',                               'path','2\2H0A0', 'procedure','2s off, 5s load H on, 10s load H and A on, 4s load A on, 9s off');
        struct('id','2H0B0','name','Soldering Station then LED Lamp',                                        'path','2\2H0B0', 'procedure','2s off, 5s load H on, 10s load H and B on, 4s load B on, 9s off');
        struct('id','2H0L0','name','Soldering Station then Resistor',                                        'path','2\2H0L0', 'procedure','2s off, 5s load H on, 10s load H and L on, 4s load L on, 9s off');
        struct('id','2H0M0','name','Soldering Station then AC Adapter Charger for Sony Vaio at 90%',         'path','2\2H0M0', 'procedure','2s off, 5s load H on, 10s load H and M on, 4s load M on, 9s off');
        struct('id','2H0N0','name','Soldering Station then Incandescent Lamp',                               'path','2\2H0N0', 'procedure','2s off, 5s load H on, 10s load H and N on, 4s load N on, 9s off');
        struct('id','2H0Q0','name','Soldering Station then Oil Heater at lower power',                       'path','2\2H0Q0', 'procedure','2s off, 5s load H on, 10s load H and Q on, 4s load Q on, 9s off');
        struct('id','2L0A0','name','Resistor then Microwave Standby',                                        'path','2\2L0A0', 'procedure','2s off, 5s load L on, 10s load L and A on, 4s load A on, 9s off');
        struct('id','2L0B0','name','Resistor then LED Lamp',                                                 'path','2\2L0B0', 'procedure','2s off, 5s load L on, 10s load L and B on, 4s load B on, 9s off');
        struct('id','2L0H0','name','Resistor then Soldering Station',                                        'path','2\2L0H0', 'procedure','2s off, 5s load L on, 10s load L and H on, 4s load H on, 9s off');
        struct('id','2L0M0','name','Resistor then AC Adapter Charger for Sony Vaio at 95%',                  'path','2\2L0M0', 'procedure','2s off, 5s load L on, 10s load L and M on, 4s load M on, 9s off');
        struct('id','2L0N0','name','Resistor then Incandescent Lamp',                                        'path','2\2L0N0', 'procedure','2s off, 5s load L on, 10s load L and N on, 4s load N on, 9s off');
        struct('id','2L0Q0','name','Resistor then Oil Heater at lower power',                                'path','2\2L0Q0', 'procedure','2s off, 5s load L on, 10s load L and Q on, 4s load Q on, 9s off');
        struct('id','2M0A0','name','AC Adapter Charger for Sony Vaio at 73% then Microwave Standby',         'path','2\2M0A0', 'procedure','2s off, 5s load M on, 10s load M and A on, 4s load A on, 9s off');
        struct('id','2M0B0','name','AC Adapter Charger for Sony Vaio at 73% then LED Lamp',                  'path','2\2M0B0', 'procedure','2s off, 5s load M on, 10s load M and B on, 4s load B on, 9s off');
        struct('id','2M0H0','name','AC Adapter Charger for Sony Vaio at 72% then Soldering Station',         'path','2\2M0H0', 'procedure','2s off, 5s load M on, 10s load M and H on, 4s load H on, 9s off');
        struct('id','2M0L0','name','AC Adapter Charger for Sony Vaio at 75% then Resistor',                  'path','2\2M0L0', 'procedure','2s off, 5s load M on, 10s load M and L on, 4s load L on, 9s off');
        struct('id','2M0N0','name','AC Adapter Charger for Sony Vaio at 73% then Incandescent Lamp',         'path','2\2M0N0', 'procedure','2s off, 5s load M on, 10s load M and N on, 4s load N on, 9s off');
        struct('id','2M0Q0','name','AC Adapter Charger for Sony Vaio at 95% then Oil Heater at lower power', 'path','2\2M0Q0', 'procedure','2s off, 5s load M on, 10s load M and Q on, 4s load Q on, 9s off');
        struct('id','2N0A','name','Incandescent Lamp then Microwave Standby',                                'path','2\2N0A0', 'procedure','2s off, 5s load N on, 10s load N and A on, 4s load A on, 9s off');
        struct('id','2N0B0','name','Incandescent Lamp then LED Lamp',                                        'path','2\2N0B0', 'procedure','2s off, 5s load N on, 10s load N and B on, 4s load B on, 9s off');
        struct('id','2N0H0','name','Incandescent Lamp then Soldering Station',                               'path','2\2N0H0', 'procedure','2s off, 5s load N on, 10s load N and H on, 4s load H on, 9s off');
        struct('id','2N0L0','name','Incandescent Lamp then Resistor',                                        'path','2\2N0L0', 'procedure','2s off, 5s load N on, 10s load N and L on, 4s load L on, 9s off');
        struct('id','2N0M0','name','Incandescent Lamp then AC Adapter Charger for Sony Vaio at 90%',         'path','2\2N0M0', 'procedure','2s off, 5s load N on, 10s load N and M on, 4s load M on, 9s off');
        struct('id','2N0Q0','name','Incandescent Lamp then Oil Heater at lower power',                       'path','2\2N0Q0', 'procedure','2s off, 5s load N on, 10s load N and Q on, 4s load Q on, 9s off');
        struct('id','2Q0A0','name','Oil Heater at lower power then Microwave Standby',                       'path','2\2Q0A0', 'procedure','2s off, 5s load Q on, 10s load Q and A on, 4s load A on, 9s off');
        struct('id','2Q0B0','name','Oil Heater at lower power then LED Lamp',                                'path','2\2Q0B0', 'procedure','2s off, 5s load Q on, 10s load Q and B on, 4s load B on, 9s off');
        struct('id','2Q0H0','name','Oil Heater at lower power then Soldering Station',                       'path','2\2Q0H0', 'procedure','2s off, 5s load Q on, 10s load Q and H on, 4s load H on, 9s off');
        struct('id','2Q0L0','name','Oil Heater at lower power then Resistor',                                'path','2\2Q0L0', 'procedure','2s off, 5s load Q on, 10s load Q and L on, 4s load L on, 9s off');
        struct('id','2Q0M0','name','Oil Heater at lower power then AC Adapter Charger for Sony Vaio at 73%', 'path','2\2Q0M0', 'procedure','2s off, 5s load Q on, 10s load Q and M on, 4s load M on, 9s off');
        struct('id','2Q0N0','name','Oil Heater at lower power then Incandescent Lamp',                       'path','2\2Q0N0', 'procedure','2s off, 5s load Q on, 10s load Q and N on, 4s load N on, 9s off');
        struct('id','3Q0X0E0','name','Oil Heater at lower power then Hair Dryer at fan speed 1 and heat level 2 then Soldering Smoke Extractor',                                         'path','3\3Q0X0E0', 'procedure','2s off, 5s load Q on, 5s load Q and X on, 5s load Q, X and E on, 4s load X and E on, 4s load E on, 5s off');
        struct('id','3Y0T0E0','name','Hair Dryer at fan speed 1 and heat level 1 then Fan Heater at maximum power then Soldering Smoke Extractor',                                       'path','3\3Y0T0E0', 'procedure','2s off, 5s load Y on, 5s load Y and T on, 5s load Y, T and E on, 4s load T and E on, 4s load E on, 5s off');
        struct('id','3M0R0X0','name','AC Adapter Charger for Sony Vaio at 90% then Oil Heater at medium power then Hair Dryer at fan speed 1 and heat level 2',                          'path','3\3M0R0X0', 'procedure','2s off, 5s load M on, 5s load M and R on, 5s load M, R and X on, 4s load R and X on, 4s load X on, 5s off');
        struct('id','3V0H0X0','name','Hair Dryer at fan speed 2 and heat level 1 then Soldering Station then Hair Dryer at fan speed 1 and Hair Dryer at fan speed 1 and heat level 2',  'path','3\3V0H0X0', 'procedure','2s off, 5s load V on, 5s load V and H on, 5s load V, H and X on, 4s load H and X on, 4s load X on, 5s off');
        struct('id','3Z0P0V0','name','Hair Dryer at fan speed 2 and heat level 1 then 2 Speed Impact Drill at higher speed then Hair Dryer at fan speed 2 and heat level 1',             'path','3\3Z0P0O0', 'procedure','2s off, 5s load Z on, 5s load Z and P on, 5s load Z, P and O on, 4s load P and O on, 4s load O on, 5s off');
        struct('id','3H0P0W0','name','Soldering Station then 2 Speed Impact Drill at higher speed then Hair Dryer at fan speed 1 and heat level 1',                                      'path','3\3H0P0W0', 'procedure','2s off, 5s load H on, 5s load H and P on, 5s load H, P and W on, 4s load P and W on, 4s load W on, 5s off');
        struct('id','3D0Y0S0','name','LED Panel then Hair Dryer at fan speed 1 and heat level 1 then 17 liters Microwave',                                                               'path','3\3D0Y0S0', 'procedure','2s off, 5s load D on, 5s load D and Y on, 5s load D, Y and S on, 4s load Y and S on, 4s load S on, 5s off');
        struct('id','3X0D0P0','name','Hair Dryer at fan speed 1 and heat level 2 then LED Panel then 2 Speed Impact Drill at higher speed',                                              'path','3\3X0D0P0', 'procedure','2s off, 5s load X on, 5s load X and D on, 5s load X, D and P on, 4s load D and P on, 4s load P on, 5s off');
        struct('id','3T0V0M0','name','Fan Heater at maximum power then Hair Dryer at fan speed 2 and heat level 1 then AC Adapter Charger for Sony Vaio at 90%',                         'path','3\3T0V0M0', 'procedure','2s off, 5s load T on, 5s load T and V on, 5s load T, V and M on, 4s load V and M on, 4s load M on, 5s off');
        struct('id','3P0U0Z0','name','2 Speed Impact Drill at higher speed then Hair Dryer at fan speed 1 and heat level 1 then Hair Dryer at fan speed 2 and heat level 1',             'path','3\3P0U0Z0', 'procedure','2s off, 5s load P on, 5s load P and U on, 5s load P, U and Z on, 4s load U and Z on, 4s load Z on, 5s off');
        struct('id','3V0D0M0','name','Hair Dryer at fan speed 2 and heat level 1 then LED Panel then AC Adapter Charger for Sony Vaio at 90%',                                           'path','3\3V0D0M0', 'procedure','2s off, 5s load V on, 5s load V and D on, 5s load V, D and M on, 4s load D and M on, 4s load M on, 5s off');
        struct('id','3W0E0T0','name','Hair Dryer at fan speed 1 and heat level 1 then Soldering Smoke Extractor then Fan Heater at maximum power',                                       'path','3\3W0E0T0', 'procedure','2s off, 5s load W on, 5s load W and E on, 5s load W, E and T on, 4s load E and T on, 4s load T on, 5s off');
        struct('id','3U0N0Z0','name','Hair Dryer at fan speed 1 and heat level 1 then Incandescent Lamp then Hair Dryer at fan speed 2 and heat level 1',                                'path','3\3U0N0Z0', 'procedure','2s off, 5s load U on, 5s load U and N on, 5s load U, N and Z on, 4s load N and Z on, 4s load Z on, 5s off');
        struct('id','3D0Q0N0','name','LED Panel then Oil Heater at lower power then Incandescent Lamp',                                                                                  'path','3\3D0Q0N0', 'procedure','2s off, 5s load D on, 5s load D and Q on, 5s load D, Q and N on, 4s load Q and N on, 4s load N on, 5s off');
        struct('id','3W0E0H0','name','Hair Dryer at fan speed 1 and heat level 1 then Soldering Smoke Extractor then Soldering Station',                                                 'path','3\3W0E0H0', 'procedure','2s off, 5s load W on, 5s load W and E on, 5s load W, E and H on, 4s load E and H on, 4s load H on, 5s off');
        struct('id','3R0E0S0','name','Oil Heater at medium power then Soldering Smoke Extractor then 17 liters Microwave',                                                               'path','3\3R0E0S0', 'procedure','2s off, 5s load R on, 5s load R and E on, 5s load R, E and S on, 4s load E and S on, 4s load S on, 5s off');
        struct('id','3P0Z0H0','name','2 Speed Impact Drill at higher speed then Hair Dryer at fan speed 2 and heat level 1 then Soldering Station',                                      'path','3\3P0Z0H0', 'procedure','2s off, 5s load P on, 5s load P and Z on, 5s load P, Z and H on, 4s load Z and H on, 4s load H on, 5s off');
        struct('id','3U0T0H0','name','Hair Dryer at fan speed 1 and heat level 1 then Fan Heater at maximum power then Soldering Station',                                               'path','3\3U0T0H0', 'procedure','2s off, 5s load U on, 5s load U and T on, 5s load U, T and H on, 4s load T and H on, 4s load H on, 5s off');
        struct('id','3D0Q0I0','name','LED Panel then Oil Heater at lower power then Phone Charger for Moto E2 at 68%',                                                                   'path','3\3D0Q0I0', 'procedure','2s off, 5s load D on, 5s load D and Q on, 5s load D, Q and I on, 4s load Q and I on, 4s load I on, 5s off');
        struct('id','3N0S0I0','name','Incandescent Lamp then 17 liters Microwave then Phone Charger for Moto E2 at 68%',                                                                 'path','3\3N0S0I0', 'procedure','2s off, 5s load N on, 5s load N and S on, 5s load N, S and I on, 4s load S and I on, 4s load I on, 5s off');
        struct('id','3V0M0Q0','name','Hair Dryer at fan speed 2 and heat level 1 then AC Adapter Charger for Sony Vaio at 90% then Oil Heater at lower power',                           'path','3\3V0M0Q0', 'procedure','2s off, 5s load V on, 5s load V and M on, 5s load V, M and Q on, 4s load M and Q on, 4s load Q on, 5s off');
        struct('id','3U0R0Y0','name','Hair Dryer at fan speed 1 and heat level 1 then Oil Heater at medium power then Hair Dryer at fan speed 1 and heat level 1',                       'path','3\3U0R0Y0', 'procedure','2s off, 5s load U on, 5s load U and R on, 5s load U, R and Y on, 4s load R and Y on, 4s load Y on, 5s off');
        struct('id','3S0E0Y0','name','17 liters Microwave then Soldering Smoke Extractor then Hair Dryer at fan speed 1 and heat level 1',                                               'path','3\3S0E0Y0', 'procedure','2s off, 5s load S on, 5s load S and E on, 5s load S, E and Y on, 4s load E and Y on, 4s load Y on, 5s off');
        struct('id','3M0W0I0','name','AC Adapter Charger for Sony Vaio at 90% then Hair Dryer at fan speed 1 and heat level 1 then Phone Charger for Moto E2 at 68%',                    'path','3\3M0W0I0', 'procedure','2s off, 5s load M on, 5s load M and W on, 5s load M, W and I on, 4s load W and I on, 4s load I on, 5s off');
        struct('id','3W0I0Z0','name','Hair Dryer at fan speed 1 and heat level 1 then Phone Charger for Moto E2 at 68% then Hair Dryer at fan speed 2 and heat level 1',                 'path','3\3W0I0Z0', 'procedure','2s off, 5s load W on, 5s load W and I on, 5s load W, I and Z on, 4s load I and Z on, 4s load Z on, 5s off');
        struct('id','3S0I0Y0','name','17 liters Microwave then Phone Charger for Moto E2 at 68% then Hair Dryer at fan speed 1 and heat level 1',                                        'path','3\3S0I0Y0', 'procedure','2s off, 5s load S on, 5s load S and I on, 5s load S, I and Y on, 4s load I and Y on, 4s load Y on, 5s off');
        struct('id','3T0Q0N0','name','Fan Heater at maximum power then Oil Heater at lower power then Incandescent Lamp',                                                                'path','3\3T0Q0N0', 'procedure','2s off, 5s load T on, 5s load T and Q on, 5s load T, Q and N on, 4s load Q and N on, 4s load N on, 5s off');
        struct('id','3X0N0R0','name','Hair Dryer at fan speed 1 and heat level 2 then Incandescent Lamp then Oil Heater at medium power',                                                'path','3\3X0N0R0', 'procedure','2s off, 5s load X on, 5s load X and N on, 5s load X, N and R on, 4s load N and R on, 4s load R on, 5s off');
        struct('id','3Y0P0U0','name','Hair Dryer at fan speed 1 and heat level 1 then 2 Speed Impact Drill at higher speed then Hair Dryer at fan speed 1 and heat level 1',             'path','3\3Y0P0U0', 'procedure','2s off, 5s load Y on, 5s load Y and P on, 5s load Y, P and U on, 4s load P and U on, 4s load U on, 5s off');
        struct('id','3M0W0R0','name','AC Adapter Charger for Sony Vaio at 90% then Hair Dryer at fan speed 1 and heat level 1 then Oil Heater at medium power',                          'path','3\3M0W0R0', 'procedure','2s off, 5s load B on, 5s load B and K on, 5s load B, K and D on, 4s load K and D on, 4s load D on, 5s off');
        struct('id','3B0K0D0','name','LED Lamp then 3 Speed Fan at highest speed then LED Panel',                                                                                        'path','3\3B0K0D0', 'procedure','2s off, 5s load M on, 5s load M and W on, 5s load M, W and R on, 4s load W and R on, 4s load R on, 5s off');
        struct('id','3E0N0Q0','name','Soldering Smoke Extractor then Incandescent Lamp then Oil Heater at lower power',                                                                  'path','3\3E0N0Q0', 'procedure','2s off, 5s load E on, 5s load E and N on, 5s load E, N and Q on, 4s load N and Q on, 4s load Q on, 5s off');
        struct('id','3Q0K0B0','name','Oil Heater at lower power then 3 Speed Fan at highest speed then LED Lamp',                                                                        'path','3\3Q0K0B0', 'procedure','2s off, 5s load Q on, 5s load Q and K on, 5s load Q, K and B on, 4s load K and B on, 4s load B on, 5s off');
        struct('id','8D0G0P0Q0M0N0H0E0','name','LED Panel then Phone Charger for ASUS X008D at 53% then 2 Speed Impact Drill at higher speed then Oil Heater at lower power then AC Adapter Charger for Sony Vaio at 90% then Incandescent Lamp then Soldering Station then Soldering Smoke Extractor',                                     'path','8\8D0G0P0Q0M0N0H0E0', 'procedure','2s off, 2s load D on, 2s load D and G on, 2s load D, G and P on, 2s load D, G, P and Q on, 2s load D, G, P, Q and M on, 2s load D, G, P, Q, M and N on, 2s load D, G, P, Q, M, N and H on, 2s load D, G, P, Q, M, N, H and E on, 2s load D, G, Q, M, N, H and E on, 2s load D, G, K, M, N and E on, 2s load G, Q, N, H, and E on, 2s load G, Q, and N on, 2s load Q, and N on, 2s load Q on, 2s load D and Q on, 2s load D on, 2s off');
        struct('id','8Q0H0N0M0P0E0I0V0','name','Oil Heater at lower power then Soldering Station then Incandescent Lamp then AC Adapter Charger for Sony Vaio at 90% then 2 Speed Impact Drill at higher speed then Soldering Smoke Extractor then Phone Charger for Moto E2 at 68% then Hair Dryer at fan speed 2 and heat level 1',       'path','8\8Q0H0N0M0P0E0I0V0', 'procedure','2s off, 2s load Q on, 2s load Q and H on, 2s load Q, H and N on, 2s load Q, H, N and M on, 2s load Q, H, N, M and P on, 2s load Q, H, N, M, P and I on, 2s load Q, H, N, M, P, I and V on, 2s load D, G, P, Q, M, N, H and E on, 2s load D, G, Q, M, N, H and E on, 2s load D, G, K, M, N and E on, 2s load G, Q, N, H, and E on, 2s load G, Q, and N on, 2s load Q, and N on, 2s load Q on, 2s load D and Q on, 2s load D on, 2s off');
        struct('id','8X0E0H0I0M0P0N0D0','name','Hair Dryer at fan speed 1 and heat level 2 then Soldering Smoke Extractor then Soldering Station then Phone Charger for Moto E2 at 68% then AC Adapter Charger for Sony Vaio at 90% then 2 Speed Impact Drill at higher speed then Incandescent Lamp then LED Panel',                       'path','8\8X0E0H0I0M0P0N0D0', 'procedure','2s off, 2s load X on, 2s load X and E on, 2s load X, E and H on, 2s load X, E, H and I on, 2s load X, E, H, I and M on, 2s load X, E, H, I, M and P on, 2s load X, E, H, I, M, P and N on, 2s load X, E, H, I, M, P, N and D on, 2s load D, G, Q, M, N, H and E on, 2s load D, G, K, M, N and E on, 2s load G, Q, N, H, and E on, 2s load G, Q, and N on, 2s load Q, and N on, 2s load Q on, 2s load D and Q on, 2s load D on, 2s off');
        struct('id','8E0P0I0M0N0H0W0Y0','name','Soldering Smoke Extractor then Soldering Smoke Extractor then Phone Charger for Moto E2 at 68% then AC Adapter Charger for Sony Vaio at 90% then Incandescent Lamp then Soldering Station then Hair Dryer at fan speed 1 and heat level 1 then Hair Dryer at fan speed 1 and heat level 1', 'path','8\8E0P0I0M0N0H0W0Y0', 'procedure','2s off, 2s load E on, 2s load E and P on, 2s load E, P and I on, 2s load E, P, I and M on, 2s load E, P, I, M and N on, 2s load E, P, I, M, N and H on, 2s load E, P, I, M, N, H and W on, 2s load E, P, I, M, N, H, W and Y on, 2s load D, G, Q, M, N, H and E on, 2s load D, G, K, M, N and E on, 2s load G, Q, N, H, and E on, 2s load G, Q, and N on, 2s load Q, and N on, 2s load Q on, 2s load D and Q on, 2s load D on, 2s off');
        struct('id','8I0E0H0D0M0N0U0Z0','name','Phone Charger for Moto E2 at 68% then Soldering Smoke Extractor then Soldering Station then LED Panel then AC Adapter Charger for Sony Vaio at 90% then Incandescent Lamp then Hair Dryer at fan speed 1 and heat level 1 then Hair Dryer at fan speed 2 and heat level 1',                 'path','8\8I0E0H0D0M0N0U0Z0', 'procedure','2s off, 2s load I on, 2s load I and E on, 2s load I, E and H on, 2s load I, E, H and D on, 2s load I, E, H, D and M on, 2s load I, E, H, D, M and N on, 2s load I, E, H, D, M, N and U on, 2s load I, E, H, D, M, N, U and Z on, 2s load D, G, Q, M, N, H and E on, 2s load D, G, K, M, N and E on, 2s load G, Q, N, H, and E on, 2s load G, Q, and N on, 2s load Q, and N on, 2s load Q on, 2s load D and Q on, 2s load D on, 2s off');
        struct('id','8D0M0S0G0H0N0R0E0','name','LED Panel then AC Adapter Charger for Sony Vaio at 90% then 17 liters Microwave then Phone Charger for ASUS X008D at 53% then Soldering Station then Incandescent Lamp then Oil Heater at medium power then Soldering Smoke Extractor',                                                     'path','8\8D0M0S0G0H0N0R0E0', 'procedure','2s off, 2s load D on, 2s load D and M on, 2s load D, M and S on, 2s load D, M, S and G on, 2s load D, M, S, G and H on, 2s load D, M, S, G, H and N on, 2s load D, M, S, G, H, N and R on, 2s load D, M, S, G, H, N, R and E on, 2s load D, G, Q, M, N, H and E on, 2s load D, G, K, M, N and E on, 2s load G, Q, N, H, and E on, 2s load G, Q, and N on, 2s load Q, and N on, 2s load Q on, 2s load D and Q on, 2s load D on, 2s off');
    ];
    
    load_desc = [
        struct('id','A0','name','Microwave, Consul 17 liters CMS18BBHNA,127V 1200W - standby 4.5W');
        struct('id','B0','name','LED Lamp, Tashibra TKl 06, 127V 6W');
        struct('id','C0','name','CRT Monitor, Sony CPD-17SF1, 127V 216W - standby 10W');
        struct('id','D0','name','LED Panel, Citiiaqua DL-500, 127V 13W');
        struct('id','E0','name','Soldering Smoke Extractor, Toyo TS-153, 127V 23W');
        struct('id','F0','name','LED monitor, AOC m2470swd2, 127V 26W, standby 0.5W');
        struct('id','G0','name','Phone Charger, Asus AD2037020, 110V-240V 38W');
        struct('id','H0','name','Soldering Station, Weller WLC100, 127V 40W');
        struct('id','I0','name','Phone Charger, Motorola SA-390M, 127V 50W');
        struct('id','J0','name','Universal Charger, LVSUN LS-PAB70, 100V-240V 70W');
        struct('id','K0','name','3 Speed Fan, Mondial V-45, 127V 80W');
        struct('id','L0','name','Resistor, Ohmtec 200ohms, 400W');
        struct('id','M0','name','AC Adapter Charger, Sony PCG-61112L, 127V 92W');
        struct('id','N0','name','Incandescent Lamp, Osram Centra A CL 100, 127V 100W');
        struct('id','O0','name','2 Speed Impact Drill, Bosch 47CV, 127V 350W');
        struct('id','P0','name','2 Speed Impact Drill, Bosch 47CV, 127V 350W');
        struct('id','Q0','name','Oil Heater, Pelonis NYLA-7, 127V 1500W');
        struct('id','R0','name','Oil Heater, Pelonis NYLA-7, 127V 1500W');
        struct('id','S0','name','Microwave, Consul CMS18BBHNA, 127V 1200W');
        struct('id','T0','name','Fan Heater, Nilko NK565, 127V 1500W');
        struct('id','U0','name','Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W');
        struct('id','V0','name','Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W');
        struct('id','W0','name','Hair Dryer, Super 4.0 SL-S04, 127V 2000W');
        struct('id','X0','name','Hair Dryer, Super 4.0 SL-S04, 127V 2000W');
        struct('id','Y0','name','Hair Dryer, Parlux 330 BR/1, 127V 2100W');
        struct('id','Z0','name','Hair Dryer, Parlux 330 BR/1, 127V 2100W');
        struct('id','2A0B0','name','Microwave, Consul 17 liters CMS18BBHNA,127V 1200W - standby 4.5W then LED Lamp, Tashibra TKl 06, 127V 6W');
        struct('id','2A0H0','name','Microwave, Consul 17 liters CMS18BBHNA,127V 1200W - standby 4.5W then Soldering Station, Weller WLC100, 127V 40W');
        struct('id','2A0L0','name','Microwave, Consul 17 liters CMS18BBHNA,127V 1200W - standby 4.5W then Resistor, Ohmtec 200ohms, 400W');
        struct('id','2A0M0','name','Microwave, Consul 17 liters CMS18BBHNA,127V 1200W - standby 4.5W then AC Adapter Charger, Sony PCG-61112L, 127V 92W');
        struct('id','2A0N0','name','Microwave, Consul 17 liters CMS18BBHNA,127V 1200W - standby 4.5W then Incandescent Lamp, Osram Centra A CL 100, 127V 100W');
        struct('id','2A0Q0','name','Microwave, Consul 17 liters CMS18BBHNA,127V 1200W - standby 4.5W then Oil Heater, Pelonis NYLA-7, 127V 1500W');
        struct('id','2B0A0','name','LED Lamp, Tashibra TKl 06, 127V 6W - standby 4.5W then Microwave, Consul 17 liters CMS18BBHNA,127V 1200W - standby 4.5W');
        struct('id','2B0H0','name','LED Lamp, Tashibra TKl 06, 127V 6W - standby 4.5W then Soldering Station, Weller WLC100, 127V 40W');
        struct('id','2B0L0','name','LED Lamp, Tashibra TKl 06, 127V 6W - standby 4.5W then Resistor, Ohmtec 200ohms, 400W');
        struct('id','2B0M0','name','LED Lamp, Tashibra TKl 06, 127V 6W - standby 4.5W then AC Adapter Charger, Sony PCG-61112L, 127V 92W');
        struct('id','2B0N0','name','LED Lamp, Tashibra TKl 06, 127V 6W - standby 4.5W then Incandescent Lamp, Osram Centra A CL 100, 127V 100W');      
        struct('id','2B0Q0','name','LED Lamp, Tashibra TKl 06, 127V 6W - standby 4.5W then Oil Heater, Pelonis NYLA-7, 127V 1500W');
        struct('id','2H0A0','name','Soldering Station, Weller WLC100, 127V 40W then Microwave, Consul 17 liters CMS18BBHNA,127V 1200W - standby 4.5W');
        struct('id','2H0B0','name','Soldering Station, Weller WLC100, 127V 40W then LED Lamp, Tashibra TKl 06, 127V 6W');
        struct('id','2H0L0','name','Soldering Station, Weller WLC100, 127V 40W then Resistor, Ohmtec 200ohms, 400W');
        struct('id','2H0M0','name','Soldering Station, Weller WLC100, 127V 40W then AC Adapter Charger, Sony PCG-61112L, 127V 92W');
        struct('id','2H0N0','name','Soldering Station, Weller WLC100, 127V 40W then Incandescent Lamp, Osram Centra A CL 100, 127V 100W');
        struct('id','2H0Q0','name','Soldering Station, Weller WLC100, 127V 40W then Oil Heater, Pelonis NYLA-7, 127V 1500W');
        struct('id','2L0A0','name','Resistor, Ohmtec 200ohms, 400W then Microwave, Consul 17 liters CMS18BBHNA,127V 1200W - standby 4.5W');
        struct('id','2L0B0','name','Resistor, Ohmtec 200ohms, 400W then LED Lamp, Tashibra TKl 06, 127V 6W');
        struct('id','2L0H0','name','Resistor, Ohmtec 200ohms, 400W then Soldering Station, Weller WLC100, 127V 40W');
        struct('id','2L0M0','name','Resistor, Ohmtec 200ohms, 400W then AC Adapter Charger, Sony PCG-61112L, 127V 92W');
        struct('id','2L0N0','name','Resistor, Ohmtec 200ohms, 400W then Incandescent Lamp, Osram Centra A CL 100, 127V 100W');
        struct('id','2L0Q0','name','Resistor, Ohmtec 200ohms, 400W then Oil Heater, Pelonis NYLA-7, 127V 1500W');
        struct('id','2M0A0','name','AC Adapter Charger, Sony PCG-61112L, 127V 92W then Microwave, Consul 17 liters CMS18BBHNA,127V 1200W - standby 4.5W');
        struct('id','2M0B0','name','AC Adapter Charger, Sony PCG-61112L, 127V 92W then LED Lamp, Tashibra TKl 06, 127V 6W');
        struct('id','2M0H0','name','AC Adapter Charger, Sony PCG-61112L, 127V 92W then Soldering Station, Weller WLC100, 127V 40W');
        struct('id','2M0L0','name','AC Adapter Charger, Sony PCG-61112L, 127V 92W then Resistor, Ohmtec 200ohms, 400W');
        struct('id','2M0N0','name','AC Adapter Charger, Sony PCG-61112L, 127V 92W then Incandescent Lamp, Osram Centra A CL 100, 127V 100W');
        struct('id','2M0Q0','name','AC Adapter Charger, Sony PCG-61112L, 127V 92W then Oil Heater, Pelonis NYLA-7, 127V 1500W');
        struct('id','2N0A0','name','Incandescent Lamp, Osram Centra A CL 100, 127V 100W then Microwave, Consul 17 liters CMS18BBHNA,127V 1200W - standby 4.5W');
        struct('id','2N0B0','name','Incandescent Lamp, Osram Centra A CL 100, 127V 100W then LED Lamp, Tashibra TKl 06, 127V 6W');
        struct('id','2N0H0','name','Incandescent Lamp, Osram Centra A CL 100, 127V 100W then Soldering Station, Weller WLC100, 127V 40W');
        struct('id','2N0L0','name','Incandescent Lamp, Osram Centra A CL 100, 127V 100W then Resistor, Ohmtec 200ohms, 400W');
        struct('id','2N0M0','name','Incandescent Lamp, Osram Centra A CL 100, 127V 100W then AC Adapter Charger, Sony PCG-61112L, 127V 92W');
        struct('id','2N0Q0','name','Incandescent Lamp, Osram Centra A CL 100, 127V 100W then Oil Heater, Pelonis NYLA-7, 127V 1500W');
        struct('id','2Q0A0','name','Oil Heater, Pelonis NYLA-7, 127V 1500W then Microwave, Consul 17 liters CMS18BBHNA,127V 1200W - standby 4.5W');
        struct('id','2Q0B0','name','Oil Heater, Pelonis NYLA-7, 127V 1500W then LED Lamp, Tashibra TKl 06, 127V 6W');
        struct('id','2Q0H0','name','Oil Heater, Pelonis NYLA-7, 127V 1500W then Soldering Station, Weller WLC100, 127V 40W');
        struct('id','2Q0L0','name','Oil Heater, Pelonis NYLA-7, 127V 1500W then Resistor, Ohmtec 200ohms, 400W');
        struct('id','2Q0M0','name','Oil Heater, Pelonis NYLA-7, 127V 1500W then AC Adapter Charger, Sony PCG-61112L, 127V 92W');
        struct('id','2Q0N0','name','Oil Heater, Pelonis NYLA-7, 127V 1500W then Incandescent Lamp, Osram Centra A CL 100, 127V 100W');
        struct('id','3Q0X0E0','name','Oil Heater, Pelonis NYLA-7, 127V 1500W then Hair Dryer, Super 4.0 SL-S04, 127V 2000W then Soldering Smoke Extractor, Toyo TS-153, 127V 23W');
        struct('id','3Y0T0E0','name','Hair Dryer, Parlux 330 BR/1, 127V 2100W then Fan Heater, Nilko NK565, 127V 1500W then Soldering Smoke Extractor, Toyo TS-153, 127V 23W');
        struct('id','3M0R0X0','name','AC Adapter Charger, Sony PCG-61112L, 127V 92W then Oil Heater, Pelonis NYLA-7, 127V 1500W then Hair Dryer, Super 4.0 SL-S04, 127V 2000W');
        struct('id','3V0H0X0','name','Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W then Soldering Station, Weller WLC100, 127V 40W then Hair Dryer, Super 4.0 SL-S04, 127V 2000W');
        struct('id','3Z0P0V0','name','Hair Dryer, Parlux 330 BR/1, 127V 2100W then 2 Speed Impact Drill, Bosch 47CV, 127V 350W then Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W');
        struct('id','3H0P0W0','name','Soldering Station, Weller WLC100, 127V 40W then 2 Speed Impact Drill, Bosch 47CV, 127V 350W then Hair Dryer, Super 4.0 SL-S04, 127V 2000W');
        struct('id','3D0Y0S0','name','LED Panel, Citiiaqua DL-500, 127V 13W then Hair Dryer, Parlux 330 BR/1, 127V 2100W then Microwave, Consul CMS18BBHNA, 127V 1200W');
        struct('id','3X0D0P0','name','Hair Dryer, Super 4.0 SL-S04, 127V 2000W then LED Panel, Citiiaqua DL-500, 127V 13W then 2 Speed Impact Drill, Bosch 47CV, 127V 350W');
        struct('id','3T0V0M0','name','Fan Heater, Nilko NK565, 127V 1500W then Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W then AC Adapter Charger, Sony PCG-61112L, 127V 92W');
        struct('id','3P0U0Z0','name','2 Speed Impact Drill, Bosch 47CV, 127V 350W then Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W then Hair Dryer, Parlux 330 BR/1, 127V 2100W');
        struct('id','3V0D0M0','name','Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W then LED Panel, Citiiaqua DL-500, 127V 13W then AC Adapter Charger, Sony PCG-61112L, 127V 92W');
        struct('id','3W0E0T0','name','Hair Dryer, Super 4.0 SL-S04, 127V 2000W then Soldering Smoke Extractor, Toyo TS-153, 127V 23W then Fan Heater, Nilko NK565, 127V 1500W');
        struct('id','3U0N0Z0','name','Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W then Incandescent Lamp, Osram Centra A CL 100, 127V 100W then Hair Dryer, Parlux 330 BR/1, 127V 2100W');
        struct('id','3D0Q0N0','name','LED Panel, Citiiaqua DL-500, 127V 13W then Oil Heater, Pelonis NYLA-7, 127V 1500W then Incandescent Lamp, Osram Centra A CL 100, 127V 100W');
        struct('id','3W0E0H0','name','Hair Dryer, Super 4.0 SL-S04, 127V 2000W then Soldering Smoke Extractor, Toyo TS-153, 127V 23W then Soldering Station, Weller WLC100, 127V 40W');
        struct('id','3R0E0S0','name','Oil Heater, Pelonis NYLA-7, 127V 1500W then Soldering Smoke Extractor, Toyo TS-153, 127V 23W then Microwave, Consul CMS18BBHNA, 127V 1200W');
        struct('id','3P0Z0H0','name','2 Speed Impact Drill, Bosch 47CV, 127V 350W then Hair Dryer, Parlux 330 BR/1, 127V 2100W then Soldering Station, Weller WLC100, 127V 40W');
        struct('id','3U0T0H0','name','Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W then Fan Heater, Nilko NK565, 127V 1500W then Soldering Station, Weller WLC100, 127V 40W');
        struct('id','3D0Q0I0','name','LED Panel, Citiiaqua DL-500, 127V 13W then Oil Heater, Pelonis NYLA-7, 127V 1500W then Phone Charger, Motorola SA-390M, 127V 50WW');
        struct('id','3N0S0I0','name','Incandescent Lamp, Osram Centra A CL 100, 127V 100W then Microwave, Consul CMS18BBHNA, 127V 1200W then Phone Charger, Motorola SA-390M, 127V 50WW');
        struct('id','3V0M0Q0','name','Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W then AC Adapter Charger, Sony PCG-61112L, 127V 92W then Oil Heater, Pelonis NYLA-7, 127V 1500W');
        struct('id','3U0T0Y0','name','Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W then Oil Heater, Pelonis NYLA-7, 127V 1500W then Hair Dryer, Parlux 330 BR/1, 127V 2100W');
        struct('id','3S0E0Y0','name','Microwave, Consul CMS18BBHNA, 127V 1200W then Soldering Smoke Extractor, Toyo TS-153, 127V 23W then Hair Dryer, Parlux 330 BR/1, 127V 2100W');
        struct('id','3M0W0I0','name','AC Adapter Charger, Sony PCG-61112L, 127V 92W then Hair Dryer, Super 4.0 SL-S04, 127V 2000W then Phone Charger, Motorola SA-390M, 127V 50W');
        struct('id','3W0I0Z0','name','Hair Dryer, Super 4.0 SL-S04, 127V 2000W then Phone Charger, Motorola SA-390M, 127V 50W then Hair Dryer, Parlux 330 BR/1, 127V 2100W');
        struct('id','3S0I0Y0','name','Microwave, Consul CMS18BBHNA, 127V 1200W then Phone Charger, Motorola SA-390M, 127V 50W then Hair Dryer, Parlux 330 BR/1, 127V 2100W');
        struct('id','3T0Q0N0','name','Fan Heater, Nilko NK565, 127V 1500W then Oil Heater, Pelonis NYLA-7, 127V 1500W then Incandescent Lamp, Osram Centra A CL 100, 127V 100W');
        struct('id','3X0N0R0','name','Hair Dryer, Super 4.0 SL-S04, 127V 2000W then Incandescent Lamp, Osram Centra A CL 100, 127V 100W then Oil Heater, Pelonis NYLA-7, 127V 1500W');
        struct('id','3Y0P0U0','name','Hair Dryer, Parlux 330 BR/1, 127V 2100W then 2 Speed Impact Drill, Bosch 47CV, 127V 350W then Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W');
        struct('id','3M0W0R0','name','AC Adapter Charger, Sony PCG-61112L, 127V 92W then Hair Dryer, Super 4.0 SL-S04, 127V 2000W then Oil Heater, Pelonis NYLA-7, 127V 1500W');
        struct('id','3B0K0D0','name','LED Lamp, Tashibra TKl 06, 127V 6W then 3 Speed Fan, Mondial V-45, 127V 80W then LED Panel, Citiiaqua DL-500, 127V 13W');
        struct('id','3E0N0Q0','name','Soldering Smoke Extractor, Toyo TS-153, 127V 23W then Incandescent Lamp, Osram Centra A CL 100, 127V 100W then Oil Heater, Pelonis NYLA-7, 127V 1500W');
        struct('id','3Q0K0B0','name','Oil Heater, Pelonis NYLA-7, 127V 1500W then 3 Speed Fan, Mondial V-45, 127V 80W then LED Lamp, Tashibra TKl 06, 127V 6W');
        struct('id','8D0G0P0Q0M0N0H0E0','name','LED Panel, Citiiaqua DL-500, 127V 13W,Phone Charger, Asus AD2037020, 110V-240V 38W,2 Speed Impact Drill, Bosch 47CV, 127V 350W,Oil Heater, Pelonis NYLA-7, 127V 1500W,AC Adapter Charger, Sony PCG-61112L, 127V 92W,Incandescent Lamp, Osram Centra A CL 100, 127V 100W,Soldering Station, Weller WLC100, 127V 40W,Soldering Smoke Extractor, Toyo TS-153, 127V 23W');
        struct('id','8Q0H0N0M0P0E0I0V0','name','Oil Heater, Pelonis NYLA-7, 127V 1500W,Soldering Station, Weller WLC100, 127V 40W,Incandescent Lamp, Osram Centra A CL 100, 127V 100W,AC Adapter Charger, Sony PCG-61112L, 127V 92W,2 Speed Impact Drill, Bosch 47CV, 127V 350W,Soldering Smoke Extractor, Toyo TS-153, 127V 23W,Phone Charger, Motorola SA-390M, 127V 50W,Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W');
        struct('id','8X0E0H0I0M0P0N0D0','name','Hair Dryer, Super 4.0 SL-S04, 127V 2000W,Soldering Smoke Extractor, Toyo TS-153, 127V 23W,Soldering Station, Weller WLC100, 127V 40W,Phone Charger, Motorola SA-390M, 127V 50W,AC Adapter Charger, Sony PCG-61112L, 127V 92W,2 Speed Impact Drill, Bosch 47CV, 127V 350W,Incandescent Lamp, Osram Centra A CL 100, 127V 100W,LED Panel, Citiiaqua DL-500, 127V 13W');
        struct('id','8E0P0I0M0N0H0W0Y0','name','Soldering Smoke Extractor, Toyo TS-153, 127V 23W,2 Speed Impact Drill, Bosch 47CV, 127V 350W,Phone Charger, Motorola SA-390M, 127V 50W,AC Adapter Charger, Sony PCG-61112L, 127V 92W,Incandescent Lamp, Osram Centra A CL 100, 127V 100W,Soldering Station, Weller WLC100, 127V 40W,Hair Dryer, Super 4.0 SL-S04, 127V 2000W,Hair Dryer, Parlux 330 BR/1, 127V 2100W');
        struct('id','8I0E0H0D0M0N0U0Z0','name','Phone Charger, Motorola SA-390M, 127V 50W,Soldering Smoke Extractor, Toyo TS-153, 127V 23W,Soldering Station, Weller WLC100, 127V 40W,LED Panel, Citiiaqua DL-500, 127V 13W,AC Adapter Charger, Sony PCG-61112L, 127V 92W,Incandescent Lamp, Osram Centra A CL 100, 127V 100W,Hair Dryer, GA.MA Italy Eleganza 2200, 127V 1900W,Hair Dryer, Parlux 330 BR/1, 127V 2100W');
        struct('id','8D0M0S0G0H0N0R0E0','name','LED Panel, Citiiaqua DL-500, 127V 13W,AC Adapter Charger, Sony PCG-61112L, 127V 92W,Microwave, Consul CMS18BBHNA, 127V 1200W,Phone Charger, Asus AD2037020, 110V-240V 38W,Soldering Station, Weller WLC100, 127V 40W,Incandescent Lamp, Osram Centra A CL 100, 127V 100W,Oil Heater, Pelonis NYLA-7, 127V 1500W,Soldering Smoke Extractor, Toyo TS-153, 127V 23W');
     ];
 %% End of 1

fprintf("Processing: %s wf:%d\n", aqID, waveform);

%% 2 - Check for valid values of input parameters

[subset,aqID,waveform] = VerifyingVar(subset, aqID, waveform);

%% 3 - Set paths
mainPath = pwd;
cd RAW_Data

%if dataset is inside simulate folder
if ( (~strcmp(subset,'Natural')) && (~strcmp(subset,'Synthetic')))
    cd Simulated
end
cd(subset);
numLoads = extractBefore(aqID, 2);
cd(numLoads)
if (~isfolder(aqID))
    error('Directory not found for the informed acquisition ID')
end
cd(aqID)
pathFile = pwd;


%% 4 - Processing the Description file
if(~isfile('Description.txt'))
    error("Description file does not exist");
end

load1 = '';
load2 = load1;
load3 = load1;
load4 = load1;
load5 = load1;
load6 = load1;
load7 = load1;
load8 = load1;

descriptionFileID = fopen(fullfile(pathFile,"Description.txt"),'r'); %modified by Filipe Chagas
line = fgetl(descriptionFileID);
while ~feof(descriptionFileID)
    line = fgetl(descriptionFileID);
    if length(line) >= 3
        if(strcmp(string(extractBetween(line,1,3)),"Dur"))
            duration = extractAfter(line,"=");
            duration = str2double(duration);
            continue;
        end
    end
    
    if length(line) >= 6
        if(strcmp(string(extractBetween(line,1,6)),"Load 1"))
            load1 = extractAfter(line,":");
            continue;
        end
        if(strcmp(string(extractBetween(line,1,6)),"Load 2"))
            load2 = extractAfter(line,":");
            continue;
        end
        if(strcmp(string(extractBetween(line,1,6)),"Load 3"))
            load3 = extractAfter(line,":");
            continue;
        end
        if(strcmp(string(extractBetween(line,1,6)),"Load 4"))
            load4 = extractAfter(line,":");
            continue;
        end
        if(strcmp(string(extractBetween(line,1,6)),"Load 5"))
            load5 = extractAfter(line,":");
            continue;
        end
        if(strcmp(string(extractBetween(line,1,6)),"Load 6"))
            load6 = extractAfter(line,":");
            continue;
        end
        if(strcmp(string(extractBetween(line,1,6)),"Load 7"))
            load7 = extractAfter(line,":");
            continue;
        end
        if(strcmp(string(extractBetween(line,1,6)),"Load 8"))
            load8 = extractAfter(line,":");
            continue;
        end
    end
    
end
fclose(descriptionFileID);



if ~exist('duration','var')
    error("Error on reading duration from Description.txt")
end

%% Creating arrays from sample files
strBase = "Samples_"; %modified by Filipe Chagas

% %% Loop over all files (different trigger angles) of a given load
% while(1)
    strNum = pad(int2str(waveform),3,'left','0');
    
    % Verifying Files
    % If an .events file and a .config_processed file don't exist, it
    % should not there be more files to be read
    % strcat(pathFile,strBase,strNum,".events")
    %if(exist(strcat(pathFile,strBase,strNum,".events"), 'file') ~= 2)   
    if(exist(fullfile(pathFile, strcat(strBase,strNum,".events")), 'file') ~= 2)   %modified by Filipe Chagas
        error("Event file does not exist");
    end
    
    %if(exist(strcat(pathFile,strBase,strNum,".config_processed"), 'file') ~= 2)
    if(exist(fullfile(pathFile, strcat(strBase,strNum,".config_processed")), 'file') ~= 2) %modified by Filipe Chagas
        error("Configuration file does not exist");
    end
    
    %if(exist(strcat(pathFile,strBase,strNum,"_0.bin"), 'file') ~= 2)
    if(exist(fullfile(pathFile, strcat(strBase,strNum,"_0.bin")), 'file') ~= 2) %modified by Filipe Chagas
        error("Binary file from channel 0 does not exist")
    end
    
    %if(exist(strcat(pathFile,strBase,strNum,"_1.bin"), 'file') ~= 2)
    if(exist(fullfile(pathFile, strcat(strBase,strNum,"_1.bin")), 'file') ~= 2) %modified by Filipe Chagas
        error("Binary file from channel 1 does not exist")
    end
    
    %if(exist(strcat(pathFile,strBase,strNum,"_2.bin"), 'file') ~= 2)
    if(exist(fullfile(pathFile, strcat(strBase,strNum,"_2.bin")), 'file') ~= 2) %modified by Filipe Chagas
        error("Binary file from channel 2 does not exist")
    end
    
    %% Gains and Offset reading
    numGainsRead = 0;
    numOffsetsRead = 0;
    
    gain = zeros(3,1);
    offset = zeros(3,1);
    
    % Read the gains from the configuration file
    configFileID = fopen(fullfile(pathFile, strcat(strBase,strNum,".config_processed"))); %modified by Filipe Chagas
    line = fgetl(configFileID);
    
    while(line ~= -1)
        if(extractBetween(line,1,3) == "Ki=" || extractBetween(line,1,3) == "Kv=")
            line = extractAfter(line,"=");
            vls = strsplit(line,",");
            
            for index_2 = 1:length(vls)
                if(numGainsRead >= 3)
                    continue
                end
                gain(numGainsRead+1) = str2double(vls(index_2));
                numGainsRead = numGainsRead + 1;
            end
        elseif(strcmp(line,'EventGlossary='))
            line = fgetl(configFileID);
            glossaryTable = strsplit(line,',');
            line = fgetl(configFileID);
            while(line ~= -1)
                glossaryTable = [glossaryTable; strsplit(line,',')];
                line = fgetl(configFileID);
            end
        end
        line = fgetl(configFileID);
    end
    
    fclose(configFileID);
    
    
    % Read offsets from the configuration file
    configFileID = fopen(fullfile(pathFile, strcat(strBase,strNum,".config_processed"))); %modified by Filipe Chagas
    line = fgetl(configFileID);
    
    while(line ~= -1)
        if(length(line) < 12)
            line = fgetl(configFileID);
            continue
        end
        
        if(extractBetween(line,1,12) == "ZeroOffsetI=" || extractBetween(line,1,12) == "ZeroOffsetV=")
            line = extractAfter(line,"=");
            vls = strsplit(line,",");
            
            for index_2 = 1:length(vls)
                if(numOffsetsRead >= 3)
                    continue
                end
                offset(numOffsetsRead+1) = str2double(vls(index_2));
                numOffsetsRead = numOffsetsRead + 1;
            end
        end
        
        if (length(line) >= 14 && extractBetween(line,1,14) == "GridFrequency=")
            line = extractAfter(line,'=');
            mains_freq = str2double(line);
        end
        
        if (length(line) >= 17 && extractBetween(line,1,17) == "SamplesFrequency=")
            line = extractAfter(line,'=');
            sps = str2double(line);
        end
        
        line = fgetl(configFileID);
    end
    
    fclose(configFileID);
    
    %% Reading and converting the samples files to -> vec_0, vec_1 and vec_2
    binFileID = fopen(fullfile(pathFile, strcat(strBase,strNum,"_0.bin"))); %modified by Filipe Chagas
    vec = fread(binFileID, Inf, 'uint16');
    fclose(binFileID);
    
    vec_0 = ((vec ./ 2) - offset(1)) .* gain(1);
    
    binFileID = fopen(fullfile(pathFile, strcat(strBase,strNum,"_1.bin"))); %modified by Filipe Chagas
    vec = fread(binFileID, Inf, 'uint16');
    fclose(binFileID);
    
    vec_1 = ((vec ./ 2) - offset(2)) .* gain(2);
    
    binFileID = fopen(fullfile(pathFile, strcat(strBase,strNum,"_2.bin"))); %modified by Filipe Chagas
    vec = fread(binFileID, Inf, 'uint16');
    fclose(binFileID);
    
    vec_2 = ((vec ./ 2) - offset(3)) .* gain(3);
    
    %% constructing the events detection marking
    vec_detection = zeros(length(vec_1),1);
    
    eventsFileID = fopen(fullfile(pathFile, strcat(strBase,strNum,".events"))); %modified by Filipe Chagas
    timestampStart = str2double(fgetl(eventsFileID));
    
    line = fgetl(eventsFileID);
    while(line ~= -1)
        cells = split(line,',');
        ts = char(cells(1));
        offsetIndex = str2double(char(cells(2)));
        event = str2double(char(cells(3)));
        
        timestampEvent = posixtime(datetime(ts,'InputFormat','yyyy:MM:dd:HH:mm:ss'));
        nSeconds = timestampEvent - timestampStart;
        sCnt = -1;
        
        for cnt = 2:length(vec_1)
            if(mod(vec(cnt),2) == 1)
                sCnt = sCnt+1;
            end
            
            if(sCnt == nSeconds)
                vec_detection(cnt+offsetIndex) = event;
                break;
            end
        end
        
        line = fgetl(eventsFileID);
    end
    fclose(eventsFileID);
    det = vec_detection;
    
    %% Constructing struct
    events = 1*(det~=0);
    events( (det==4)|(det==8)|(det==12)|(det==16)|...
        (det==20)|(det==24)|(det==28)|(det==32) ) = -1;
    label = string(det);
    label((det==7)|(det==4)) = glossaryTable((string(glossaryTable)=="7"),2);
    label((det==11)|(det==8)) = glossaryTable((string(glossaryTable)=="11"),2);
    label((det==15)|(det==12)) = glossaryTable((string(glossaryTable)=="15"),2);
    label((det==19)|(det==16)) = glossaryTable((string(glossaryTable)=="19"),2);
    label((det==23)|(det==20)) = glossaryTable((string(glossaryTable)=="23"),2);
    label((det==27)|(det==24)) = glossaryTable((string(glossaryTable)=="27"),2);
    label((det==31)|(det==28)) = glossaryTable((string(glossaryTable)=="31"),2);
    label((det==35)|(det==32)) = glossaryTable((string(glossaryTable)=="35"),2);
    

    aqStruct = struct('iShunt',vec_0,'iHall',vec_1,'vGrid',vec_2,'events_r',events,'labels',label,'duration_t',duration);

    % Go to the next file
%    fileNumber = fileNumber + 1;
%end

%% Save struct
cd(mainPath);
if ~isfolder('Matlab_Data')
    mkdir('Matlab_Data');
    %        addpath(genpath('Matlab'))
    fprintf("Directory 'Matlab_Data' created\n");
end
cd Matlab_Data;
% save specific waveform

% specific subset file
if ( (~strcmp(subset,'Natural')) && (~strcmp(subset,'Synthetic')))
    if ~isfolder('Simulated')
        mkdir('Simulated');
    end
    cd Simulated
end

if ~isfolder(subset)
    mkdir(subset);
    s = strcat("Directory ", subset, " created\n");
    fprintf(s);
end
cd(subset)



if ~isfolder(numLoads)
    mkdir(numLoads);
    s = strcat("Directory ", numLoads, " created\n");
    fprintf(s);
end
cd(numLoads)

if ~isfolder(aqID)
    mkdir(aqID);
    s = strcat("Directory ", aqID, " created\n");
    fprintf(s);
end
cd(aqID)

%%DR
filenumber_offset = str2num(numLoads)*10000 + file_offset_in_loadset;


acquisition_descr = '';
load_descr = '';

if strcmp(subset,'Synthetic')
    found_name = false;
    for i = 1 : length(acquisition_desc)
        if (strcmp(acquisition_desc(i).id,aqID))
            found_name = true;
            break;
        end
    end
    
    if found_name
        acquisition_descr = strcat(acquisition_desc(i).name,': ', acquisition_desc(i).procedure) ;
        load_descr = load_desc(i).name;
    end
end

if ( (~strcmp(subset,'Natural')) && (~strcmp(subset,'Synthetic')))
    % for the variations of Simmulated subset use:
    load_descr = char(strcat(load1,load2,load3,load4,load5,load6,load7,load8));
    acquisition_descr = char(sprintf("%s: %s load(s), %u seconds",subset,numLoads,int32(aqStruct.duration_t)));
end

fileName = strcat('Waveform',num2str(waveform+filenumber_offset));
iShunt = aqStruct.iShunt;
iHall = aqStruct.iHall;
vGrid = aqStruct.vGrid;
events_r = aqStruct.events_r;
labels = aqStruct.labels;
labels = cellstr(labels); %added by Filipe Chagas
duration_t = aqStruct.duration_t;
load_descr_short = aqID;
save(fileName,'iShunt','iHall','vGrid','events_r','labels','duration_t','mains_freq','sps','acquisition_descr','load_descr_short','load_descr','waveform');
    


cd(mainPath);
%fprintf("Done!\n");
end
