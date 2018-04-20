ALL_county_specialty_count <- bind_rows(ANTHEM_county_specialty_count, 
                                        BRIGHT_county_specialty_count, 
                                        CIGNA_county_specialty_count, 
                                        DENVER_HEALTH_county_specialty_count, 
                                        KAISER_county_specialty_count, 
                                        RMHP_county_specialty_count)

ALL_statewide_specialty_count <- bind_rows(ANTHEM_statewide_specialty_count, 
                                        BRIGHT_statewide_specialty_count, 
                                        CIGNA_statewide_specialty_count, 
                                        DENVER_HEALTH_statewide_specialty_count, 
                                        KAISER_statewide_specialty_count, 
                                        RMHP_statewide_specialty_count)