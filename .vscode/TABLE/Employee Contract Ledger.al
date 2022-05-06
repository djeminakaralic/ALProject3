table 50071 "Employee Contract Ledger"
{
    Caption = 'Employee Contract Ledger';
    DrillDownPageID = "Employee Contract Ledger";
    LookupPageID = "Employee Contract Ledger";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry  No.';
        }
        field(2; Description; Text[20])
        {
            Caption = 'Description';
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN
                    EVALUATE(Order, "Employee No.");
            end;
        }
        field(4; "Contract Activation Date"; Date)
        {
            Caption = 'Contract Activation Date';
        }
        field(5; "Contract Termination Date"; Date)
        {
            Caption = 'Contract Termination Date';
        }
        field(7; "Contract Type"; Code[20])
        {
            Caption = 'Contract Type';
            Editable = true;
            TableRelation = "Employment Contract".Code;


            trigger OnValidate()
            begin

                IF "Contract Type" <> '' THEN BEGIN
                    EmploymentContract.SETFILTER(code, '%1', "Contract Type");
                    IF EmploymentContract.FINDFIRST THEN BEGIN
                        //VALIDATE("Contract Type",EmploymentContract.Code)
                        "Contract Type Name" := EmploymentContract.Description;
                    END;
                END
                ELSE BEGIN
                    // VALIDATE("Contract Type",'');
                    "Contract Type Name" := '';
                END;


                CountYears1 := 0;
                CountMonths1 := 0;
                CountDays1 := 0;
                /***************NOVA VERZIJA*****************/
                /*********************************tRY**********************************/
                IF ("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI') THEN BEGIN
                    RecDate1.RESET;
                    RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                    RecDate1.SETRANGE("Period Start", "Starting Date", "Ending Date");
                    IF RecDate1.FINDSET THEN BEGIN
                        LastFoundDate1 := "Starting Date";
                        // *** find count of years ***
                        TempDate1 := CALCDATE('<+1Y-1D>', LastFoundDate1);
                        Found1 := TRUE;
                        CountYears1 := 0;
                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                            CountYears1 := 1;
                            LastFoundDate1 := TempDate1;
                            TempDate1 := CALCDATE('<+2Y-1D>', "Starting Date");
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountYears1 := 2;
                                LastFoundDate1 := TempDate1;
                            END;
                        END;

                        // *** find count of months ***
                        IF CountYears1 = 0 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M-1D>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<9M-1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        // *** find count of months ***
                        IF CountYears1 = 1 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<1Y+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<+1Y+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<1Y+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<1Y+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<1Y+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<1Y+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<1Y+5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+1Y+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<1Y+6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<1Y+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<1Y+7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<1Y+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<1Y+8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<+1Y+8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<1Y+9M+1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<1Y+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<1Y+10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<+1Y+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<1Y+11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<1Y+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        // *** find count of months ***
                        IF CountYears1 = 2 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<2Y+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<2Y+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<2Y+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<2Y+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<2Y+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<2Y+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<2Y+5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+2Y+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<2Y+6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<2Y+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<2Y+7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<2Y+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<2Y+8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<2Y+8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<2Y+9M+1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<+2Y+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<2Y+10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<2Y+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<2Y+11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<2Y+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        "Work Days" := CountDays1;
                        "Work Months" := CountMonths1;
                        "Work Years" := CountYears1;
                    END;
                END
                ELSE BEGIN
                    "Work Days" := 0;
                    "Work Months" := 0;
                    "Work Years" := 0;
                END;
                IF ("Starting Date" = 0D) OR ("Ending Date" = 0D) THEN BEGIN
                    "Work Days" := 0;
                    "Work Months" := 0;
                    "Work Years" := 0;
                END;

                IF ("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI') OR ("Contract Type" = '5') THEN BEGIN
                    IF
                    ("Work Months" = 0) AND ("Work Years" = 0) AND ("Ending Date" <> 0D) AND ("Starting Date" <> 0D) THEN BEGIN
                        CountDays1 := 1;
                        TempDate1 := CALCDATE('<+1D>', "Starting Date");
                        Found1 := TRUE;
                        REPEAT
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountDays1 += 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<+1D>', TempDate1);
                            END ELSE
                                Found1 := FALSE;
                        UNTIL NOT Found1;
                        "Work Days" := CountDays1;
                    END;
                END;


                EngagementType.RESET;
                EngagementType.SETFILTER(Description, '%1', Rec."Engagement Type");
                IF EngagementType.FINDFIRST THEN BEGIN

                    IF (EngagementType.Code = '5') OR (EngagementType.Code = '2') THEN BEGIN
                        "Testing Period" := TRUE;
                        "Testing Period Starting Date" := "Starting Date";
                    END
                    ELSE BEGIN
                        "Testing Period" := FALSE;
                        "Testing Period Starting Date" := 0D;
                    END;
                END;
                IF "Employee No." <> '' THEN BEGIN
                    "Order By" := 5;
                    /*IF "Position Description"='VD*' THEN
                    "Order By":=1;*/
                    IF STRPOS("Position Description", 'VD') <> 0 THEN
                        "Order By" := 1;
                    IF ("Additional Benefits") AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 2;
                    IF ("Temporary disposition" = TRUE) AND ("Additional Benefits" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 3;
                    IF (("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI') OR ("Contract Type" = '5')) AND ("Additional Benefits" = FALSE) AND ("Temporary disposition" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 4
                END;







                Validate("Contract Type Name", "Contract Type Name");

            end;
        }
        field(8; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';


            trigger OnValidate()
            begin
                IF ("Grounds for Term. Code" <> '') AND ("Ending Date" = 0D) THEN
                    ERROR(Text010, "Employee No.", "Ending Date")
                ELSE BEGIN
                    /*IF "Ending Date"<TODAY THEN
                      ERROR(Text011);*/
                    IF ("Grounds for Term. Code" <> '') AND ("Ending Date" <= CALCDATE('-1D', TODAY)) THEN BEGIN
                        Employee1.RESET;
                        Employee1.SETFILTER("No.", "Employee No.");
                        IF Employee1.FINDFIRST THEN BEGIN
                            Employee1.VALIDATE("Termination Date", "Ending Date");
                            Employee1.VALIDATE("Grounds for Term. Code", "Grounds for Term. Code");
                            IF (Employee1.StatusExt.AsInteger() < 4) THEN
                                Employee1.VALIDATE(StatusExt, 3)
                            ELSE BEGIN
                                Employee1.VALIDATE("External employer Status", 4);
                            END;
                            //Employee1.VALIDATE(Status,Employee1.Status::Terminated);
                            Employee1.MODIFY;
                            VALIDATE(Status, Status::Terminated);
                            MODIFY;
                        END;
                    END;


                    /*IF "Grounds for Term. Code"<>'' THEN BEGIN
                      GroundsForTermination.RESET;
                      //GroundsForTermination.SETFILTER(Type,'Reason');
                      GroundsForTermination.SETFILTER("Code Reason","Grounds for Term. Code");
                      IF GroundsForTermination.FINDFIRST THEN
                        "Grounds for Term. Description":=GroundsForTermination."Description Reason";
                      END
                      ELSE
                        "Grounds for Term. Description":='';*/


                    IF (("Grounds for Term. Code" <> '') AND ("Ending Date" >= (20180901D))) AND ("Ending Date" <= CALCDATE('-1D', TODAY)) THEN BEGIN
                        // IF (("Grounds for Term. Code"<>'') AND ("Ending Date">=(090117D)))  THEN BEGIN
                        /*WPConnSetup.FINDFIRST();


                                       CREATE(conn, TRUE, TRUE);

                                       conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                                                 +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));

                                       CREATE(comm,TRUE, TRUE);

                                       lvarActiveConnection := conn;
                                       comm.ActiveConnection := lvarActiveConnection;

                                       comm.CommandText := 'dbo.User_TerminationDate';
                                       comm.CommandType := 4;
                                       comm.CommandTimeout := 0;


                                        param:=comm.CreateParameter('@EmployeeNo', 200, 1, 30, "Employee No.");
                                       comm.Parameters.Append(param);

                                       param:=comm.CreateParameter('@Termination_date', 7, 1, 0, "Ending Date");
                                       comm.Parameters.Append(param);



                                        comm.Execute;
                                        conn.Close;
                                        CLEAR(conn);
                                        CLEAR(comm);*/

                        WPConnSetup.FINDFIRST();
                        /* ConnectionString := 'Server=' + WPConnSetup.Server + ';'
                         + 'Database=' + WPConnSetup.Database + ';'
                         + 'Uid=' + WPConnSetup.UID + ';'
                         + 'Pwd=' + WPConnSetup.Password + ';';
                         SQLConn := SQLConn.SqlConnection(ConnectionString);
                         SQLConn.Open;

                         SQLCommand := SQLCommand.SqlCommand();

                         SQLCommand.CommandText := 'dbo.User_TerminationDate';
                         SQLCommand.Connection := SQLConn;
                         SQLCommand.CommandType := 4;
                         SQLCommand.CommandTimeout := 0;

                         SQLParameter := SQLParameter.SqlParameter;
                         SQLParameter.ParameterName := '@EmployeeNo';
                         SQLParameter.DbType := SQLDbType.String;
                         SQLParameter.Direction := SQLParameter.Direction.Input;
                         SQLParameter.Value := "Employee No.";
                         SQLCommand.Parameters.Add(SQLParameter);


                         SQLParameter := SQLParameter.SqlParameter;
                         SQLParameter.ParameterName := '@Termination_date';
                         SQLParameter.DbType := SQLDbType.Date;
                         SQLParameter.Direction := SQLParameter.Direction.Input;
                         SQLParameter.Value := "Ending Date";
                         SQLCommand.Parameters.Add(SQLParameter);
                         SQLCommand.ExecuteNonQuery;




                         SQLConn.Close;
                         SQLConn.Dispose;ĐK*/


                    END
                    ELSE BEGIN
                        /*ĐK  WPConnSetup.FINDFIRST();
                          ConnectionString := 'Server=' + WPConnSetup.Server + ';'
                          + 'Database=' + WPConnSetup.Database + ';'
                          + 'Uid=' + WPConnSetup.UID + ';'
                          + 'Pwd=' + WPConnSetup.Password + ';';
                          SQLConn := SQLConn.SqlConnection(ConnectionString);
                          SQLConn.Open;

                          SQLCommand := SQLCommand.SqlCommand();

                          SQLCommand.CommandText := 'dbo.User_TerminationDate';
                          SQLCommand.Connection := SQLConn;
                          SQLCommand.CommandType := 4;
                          SQLCommand.CommandTimeout := 0;

                          SQLParameter := SQLParameter.SqlParameter;
                          SQLParameter.ParameterName := '@EmployeeNo';
                          SQLParameter.DbType := SQLDbType.String;
                          SQLParameter.Direction := SQLParameter.Direction.Input;
                          SQLParameter.Value := "Employee No.";
                          SQLCommand.Parameters.Add(SQLParameter);
                          //1899-12-30 00:00:00.000
                          Empty := DMY2DATE(30, 12, 1899);
                          SQLParameter := SQLParameter.SqlParameter;
                          SQLParameter.ParameterName := '@Termination_date';
                          SQLParameter.DbType := SQLDbType.Date;
                          SQLParameter.Direction := SQLParameter.Direction.Input;
                          SQLParameter.Value := Empty;
                          SQLCommand.Parameters.Add(SQLParameter);
                          SQLCommand.ExecuteNonQuery;




                          SQLConn.Close;
                          SQLConn.Dispose;ĐK*/

                    END;
                END;

            end;
        }
        field(9; Netto; Decimal)
        {
            Caption = 'Wage BasisNetto';

            trigger OnValidate()
            begin
                //WG01
                Employee.SETFILTER("No.", "Employee No.");
                IF Employee.FINDFIRST THEN BEGIN
                    ConCat.SETFILTER(Code, '%1', Employee."Contribution Category Code");
                    IF ConCat.FINDFIRST THEN BEGIN
                        ConCat.CALCFIELDS("From Brutto");



                        Rec."Tax Deduction Amount" := Employee."Tax Deduction Amount";
                        Rec.VALIDATE(Brutto, (Netto) / ((1 - ConCat."From Brutto" / 100) * 0.9));
                        BruttoAfterContributionWE := (Rec.Brutto + (Rec.Brutto * (Employee."Work Experience Percentage") / 100)) - (((Rec.Brutto + (Rec.Brutto * (Employee."Work Experience Percentage") / 100)) * ConCat."From Brutto") / 100);
                        BruttoAfterDeductionWE := BruttoAfterContributionWE;
                        IF BruttoAfterDeductionWE <> 0 THEN
                            TaxWe := (BruttoAfterDeductionWE - "Tax Deduction Amount") * 0.1
                        ELSE
                            TaxWe := 0;

                        Rec."Total Netto" := BruttoAfterContributionWE - TaxWe;
                        IF Rec."No." <> 0 THEN
                            Rec.MODIFY;
                    END;
                END;

                IF Brutto < HRSetup."Fixed Amount Brutto" THEN BEGIN
                    VALIDATE("Fixed Amount Brutto", Brutto - HRSetup."Variable Amount Brutto Less");
                    VALIDATE("Variable Amount Brutto", Brutto - HRSetup."Variable Amount Brutto Less");
                END
                ELSE BEGIN
                    VALIDATE("Fixed Amount Brutto", Brutto - HRSetup."Variable Amount Brutto Greater");
                    VALIDATE("Variable Amount Brutto", Brutto - HRSetup."Variable Amount Brutto Greater");
                END;
                //WG01
                IF (("Manager Contract" = TRUE) AND ("Percentage of Fixed Part" <> 0)) THEN BEGIN
                    "Fixed Amount Brutto" := ("Percentage of Fixed Part" / 100) * Brutto;
                    "Fixed Amount Netto" := ("Percentage of Fixed Part" / 100) * Rec.Netto;
                    "Fixed Amount Total Netto" := ("Percentage of Fixed Part" / 100) * "Total Netto";
                    "Variable Amount Brutto" := (1 - ("Percentage of Fixed Part" / 100)) * Brutto;
                    "Variable Amount Netto" := (1 - ("Percentage of Fixed Part" / 100)) * Rec.Netto;
                    "Manager Addition Total Netto" := (1 - ("Percentage of Fixed Part" / 100)) * "Total Netto";
                END;
            end;
        }
        field(10; Brutto; Decimal)
        {
            Caption = 'Wage Basis Brutto';

            trigger OnValidate()
            begin
                HRSetup.GET;
                IF ((Brutto < HRSetup."Variable Amount Brutto Less") AND (Brutto <> 0)) THEN ERROR(Text008);
                Employee.SETFILTER("No.", "Employee No.");
                IF Employee.FINDFIRST THEN BEGIN
                    BruttoAfterDeduction := 0;
                    ConCat.SETFILTER(Code, '%1', Employee."Contribution Category Code");
                    IF ConCat.FINDFIRST THEN BEGIN
                        ConCat.CALCFIELDS("From Brutto");
                        BruttoAfterContribution := Rec.Brutto - ((Rec.Brutto * ConCat."From Brutto") / 100);
                        BruttoAfterContributionWE := (Rec.Brutto + (Rec.Brutto * (Employee."Work Experience Percentage") / 100)) - (((Rec.Brutto + (Rec.Brutto * (Employee."Work Experience Percentage") / 100)) * ConCat."From Brutto") / 100);
                    END;

                    BruttoAfterDeduction := BruttoAfterContribution;
                    BruttoAfterDeductionWE := BruttoAfterContributionWE;
                    "Tax Deduction Amount" := Employee."Tax Deduction Amount";
                    IF BruttoAfterDeductionWE <> 0 THEN
                        TaxWe := (BruttoAfterDeductionWE - "Tax Deduction Amount") * 0.1
                    ELSE
                        TaxWe := 0;
                    Rec.Tax := BruttoAfterDeduction * 0.1;//!
                    Rec."Brutto After Contributtion" := BruttoAfterContribution;
                    Rec.Netto := BruttoAfterContribution - Tax;
                    Rec."Total Netto" := BruttoAfterContributionWE - TaxWe;
                    IF Rec."No." <> 0 THEN
                        Rec.MODIFY;

                END;



                HRSetup.GET;
                IF Brutto < HRSetup."Fixed Amount Brutto" THEN BEGIN
                    IF Brutto <> 0 THEN BEGIN
                        "Fixed Amount Brutto" := Brutto - HRSetup."Variable Amount Brutto Less";
                        "Percentage of Fixed Part" := ("Fixed Amount Brutto" / Brutto) * 100;
                        "Fixed Amount Netto" := ("Percentage of Fixed Part" / 100) * Rec.Netto;
                        "Fixed Amount Total Netto" := ("Percentage of Fixed Part" / 100) * "Total Netto";
                        "Variable Amount Brutto" := HRSetup."Variable Amount Brutto Less";
                        "Variable Amount Netto" := (1 - ("Percentage of Fixed Part" / 100)) * Rec.Netto;
                        "Percentage of Variable" := (100 - "Percentage of Fixed Part");
                    END
                    ELSE BEGIN
                        "Fixed Amount Brutto" := 0;
                        "Percentage of Fixed Part" := 0;
                        "Fixed Amount Netto" := 0;
                        "Fixed Amount Total Netto" := 0;
                        "Variable Amount Brutto" := 0;
                        "Variable Amount Netto" := 0;
                        "Percentage of Variable" := 0;
                        "Percentage of Variable" := 0;
                    END;
                END;

                IF Brutto >= HRSetup."Fixed Amount Brutto" THEN BEGIN
                    IF Brutto <> 0 THEN BEGIN
                        "Fixed Amount Brutto" := Brutto - HRSetup."Variable Amount Brutto Greater";
                        "Percentage of Fixed Part" := ("Fixed Amount Brutto" / Brutto) * 100;
                        "Fixed Amount Netto" := ("Percentage of Fixed Part" / 100) * Rec.Netto;
                        "Fixed Amount Total Netto" := ("Percentage of Fixed Part" / 100) * "Total Netto";
                        "Variable Amount Brutto" := HRSetup."Variable Amount Brutto Greater";
                        "Variable Amount Netto" := (1 - ("Percentage of Fixed Part" / 100)) * Rec.Netto;
                        "Percentage of Variable" := (100 - "Percentage of Fixed Part");
                    END
                    ELSE BEGIN
                        "Fixed Amount Brutto" := 0;
                        "Percentage of Fixed Part" := 0;
                        "Fixed Amount Netto" := 0;
                        "Fixed Amount Total Netto" := 0;
                        "Variable Amount Brutto" := 0;
                        "Variable Amount Netto" := 0;
                        "Percentage of Variable" := 0;
                    END;
                END;

                IF Active = TRUE THEN BEGIN
                    IF "Starting Date" <> 0D THEN BEGIN
                        // IF DATE2DMY("Starting Date",1)=1 THEN
                        BEGIN
                            //NK xRec.FINDLAST;
                            IF (xRec."No." = Rec."No.") THEN BEGIN
                                xRec.RESET;
                                WageAmounts.RESET;
                                WageAmounts.SETFILTER("Employee No.", "Employee No.");
                                IF WageAmounts.FINDFIRST THEN BEGIN
                                    WageAmounts.VALIDATE("Wage Amount", Brutto);
                                    IF DATE2DMY("Starting Date", 1) <> 0 THEN BEGIN
                                        EmployeeContractLedger.RESET;
                                        EmployeeContractLedger.SETCURRENTKEY("Employee No.", "Starting Date");
                                        EmployeeContractLedger.SETFILTER("Employee No.", "Employee No.");
                                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                                        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
                                        IF EmployeeContractLedger.FINDLAST THEN BEGIN
                                            EmployeeContractLedgerPrevious := EmployeeContractLedger;
                                            EmployeeContractLedgerPrevious.setfilter("Employee No.", "Employee No.");
                                            EmployeeContractLedgerPrevious.SETFILTER("Show Record", '%1', TRUE);
                                            EmployeeContractLedgerPrevious.SETCURRENTKEY("Employee No.", "Starting Date");
                                            EmployeeContractLedgerPrevious.NEXT(-1);
                                            IF EmployeeContractLedgerPrevious.Brutto <> Brutto THEN BEGIN
                                                WageAmounts.VALIDATE("Old Amount", EmployeeContractLedgerPrevious.Brutto);
                                                WageAmounts.VALIDATE("Application Date", Rec."Starting Date");
                                            END;
                                        END;
                                    END;
                                    WageAmounts.MODIFY;
                                END
                                ELSE BEGIN
                                    WageAmounts.RESET;
                                    WageAmounts.INIT;
                                    WageAmounts.VALIDATE("Employee No.", "Employee No.");
                                    WageAmounts.VALIDATE("Wage Amount", Brutto);
                                    IF DATE2DMY("Starting Date", 1) <> 1 THEN BEGIN
                                        EmployeeContractLedger.RESET;
                                        EmployeeContractLedger.SETCURRENTKEY("Employee No.", "Starting Date");
                                        EmployeeContractLedger.SETFILTER("Employee No.", "Employee No.");
                                        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
                                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                                        IF EmployeeContractLedger.FINDLAST THEN BEGIN
                                            EmployeeContractLedgerPrevious := EmployeeContractLedger;
                                            EmployeeContractLedgerPrevious.SETFILTER("Show Record", '%1', TRUE);
                                            EmployeeContractLedgerPrevious.setfilter("Employee No.", "Employee No.");
                                            EmployeeContractLedgerPrevious.SETCURRENTKEY("Employee No.", "Starting Date");
                                            EmployeeContractLedgerPrevious.NEXT(-1);
                                            IF EmployeeContractLedgerPrevious.Brutto <> Brutto THEN BEGIN
                                                WageAmounts.VALIDATE("Old Amount", EmployeeContractLedgerPrevious.Brutto);
                                                WageAmounts.VALIDATE("Application Date", EmployeeContractLedger."Starting Date");
                                            END;
                                        END;
                                    END;
                                    WageAmounts.INSERT;
                                END;
                            END
                        END;
                    END;

                END;
            end;
        }
        field(11; "Testing Period"; Boolean)
        {
            Caption = 'Testing Period';

            trigger OnValidate()
            begin


                /*********************************tRY**********************************/
                RecDate.RESET;
                RecDate.SETRANGE("Period Type", RecDate."Period Type"::Date);
                RecDate.SETRANGE("Period Start", "Testing Period Starting Date", "Testing Period Ending Date");
                IF RecDate.FINDSET THEN BEGIN
                    LastFoundDate := "Testing Period Starting Date";
                    // *** find count of years ***
                    TempDate := CALCDATE('<+1Y-1D>', LastFoundDate);
                    Found := TRUE;
                    CountYears := 0;
                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                        CountYears := 1;
                        LastFoundDate := TempDate;
                        TempDate := CALCDATE('<+2Y-1D>', "Testing Period Starting Date");
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountYears := 2;
                            LastFoundDate := TempDate;
                        END;
                    END;

                    // *** find count of months ***
                    IF CountYears = 0 THEN BEGIN
                        TempDate := CALCDATE('<+1M-1D>', LastFoundDate);
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountMonths := 1;
                            LastFoundDate := TempDate;
                            TempDate := CALCDATE('<+2M-1D>', "Testing Period Starting Date");
                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                TempDate := CALCDATE('<+2M>', "Testing Period Starting Date");
                            END;
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountMonths := 2;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<+3M-1D>', "Testing Period Starting Date");
                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                    TempDate := CALCDATE('<+3M>', "Testing Period Starting Date");
                                END;
                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                    CountMonths := 3;
                                    LastFoundDate := TempDate;
                                    TempDate := CALCDATE('<+4M-1D>', "Testing Period Starting Date");
                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                        TempDate := CALCDATE('<+4M>', "Testing Period Starting Date");
                                    END;
                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                        CountMonths := 4;
                                        LastFoundDate := TempDate;
                                        TempDate := CALCDATE('<5M-1D>', "Testing Period Starting Date");
                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                            TempDate := CALCDATE('<+5M>', "Testing Period Starting Date");
                                        END;
                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                            CountMonths := 5;
                                            LastFoundDate := TempDate;
                                            TempDate := CALCDATE('<6M-1D>', "Testing Period Starting Date");
                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                TempDate := CALCDATE('<+6M>', "Testing Period Starting Date");
                                            END;
                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                CountMonths := 6;
                                                LastFoundDate := TempDate;
                                                TempDate := CALCDATE('<7M-1D>', "Testing Period Starting Date");
                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                    TempDate := CALCDATE('<+7M>', "Testing Period Starting Date");
                                                END;
                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                    CountMonths := 7;
                                                    LastFoundDate := TempDate;
                                                    TempDate := CALCDATE('<8M-1D>', "Testing Period Starting Date");
                                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                        TempDate := CALCDATE('<8M>', "Testing Period Starting Date");
                                                    END;
                                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                        CountMonths := 8;
                                                        LastFoundDate := TempDate;
                                                        TempDate := CALCDATE('<9M-1D>', "Testing Period Starting Date");
                                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                            TempDate := CALCDATE('<+9M>', "Testing Period Starting Date");
                                                        END;
                                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                            CountMonths := 9;
                                                            LastFoundDate := TempDate;
                                                            TempDate := CALCDATE('<10M-1D>', "Testing Period Starting Date");
                                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                TempDate := CALCDATE('<+10M>', "Testing Period Starting Date");
                                                            END;
                                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                CountMonths := 10;
                                                                LastFoundDate := TempDate;
                                                                TempDate := CALCDATE('<11M-1D>', "Testing Period Starting Date");
                                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                    TempDate := CALCDATE('<+11M>', "Testing Period Starting Date");
                                                                END;
                                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                    CountMonths := 11;
                                                                    LastFoundDate := TempDate;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                        END;
                        // *** find count of days ***
                        TempDate := CALCDATE('<+1D>', LastFoundDate);
                        Found := TRUE;
                        REPEAT
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountDays += 1;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<+1D>', TempDate);
                            END ELSE
                                Found := FALSE;
                        UNTIL NOT Found;
                    END;
                    // *** find count of months ***
                    IF CountYears = 1 THEN BEGIN
                        TempDate := CALCDATE('<+1M>', LastFoundDate);
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountMonths := 1;
                            LastFoundDate := TempDate;
                            TempDate := CALCDATE('<1Y+2M-1D>', "Testing Period Starting Date");
                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                TempDate := CALCDATE('<+1Y+2M>', "Testing Period Starting Date");
                            END;
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountMonths := 2;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<1Y+3M-1D>', "Testing Period Starting Date");
                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                    TempDate := CALCDATE('<1Y+3M>', "Testing Period Starting Date");
                                END;
                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                    CountMonths := 3;
                                    LastFoundDate := TempDate;
                                    TempDate := CALCDATE('<1Y+4M-1D>', "Testing Period Starting Date");
                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                        TempDate := CALCDATE('<1Y+4M>', "Testing Period Starting Date");
                                    END;
                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                        CountMonths := 4;
                                        LastFoundDate := TempDate;
                                        TempDate := CALCDATE('<1Y+5M-1D>', "Testing Period Starting Date");
                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                            TempDate := CALCDATE('<+1Y+5M>', "Testing Period Starting Date");
                                        END;
                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                            CountMonths := 5;
                                            LastFoundDate := TempDate;
                                            TempDate := CALCDATE('<1Y+6M-1D>', "Testing Period Starting Date");
                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                TempDate := CALCDATE('<1Y+6M>', "Testing Period Starting Date");
                                            END;
                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                CountMonths := 6;
                                                LastFoundDate := TempDate;
                                                TempDate := CALCDATE('<1Y+7M-1D>', "Testing Period Starting Date");
                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                    TempDate := CALCDATE('<1Y+7M>', "Testing Period Starting Date");
                                                END;
                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                    CountMonths := 7;
                                                    LastFoundDate := TempDate;
                                                    TempDate := CALCDATE('<1Y+8M-1D>', "Testing Period Starting Date");
                                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                        TempDate := CALCDATE('<+1Y+8M>', "Testing Period Starting Date");
                                                    END;
                                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                        CountMonths := 8;
                                                        LastFoundDate := TempDate;
                                                        TempDate := CALCDATE('<1Y+9M+1D>', "Testing Period Starting Date");
                                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                            TempDate := CALCDATE('<1Y+9M>', "Testing Period Starting Date");
                                                        END;
                                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                            CountMonths := 9;
                                                            LastFoundDate := TempDate;
                                                            TempDate := CALCDATE('<1Y+10M-1D>', "Testing Period Starting Date");
                                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                TempDate := CALCDATE('<+1Y+10M>', "Testing Period Starting Date");
                                                            END;
                                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                CountMonths := 10;
                                                                LastFoundDate := TempDate;
                                                                TempDate := CALCDATE('<1Y+11M-1D>', "Testing Period Starting Date");
                                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                    TempDate := CALCDATE('<1Y+11M>', "Testing Period Starting Date");
                                                                END;
                                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                    CountMonths := 11;
                                                                    LastFoundDate := TempDate;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                        END;
                        // *** find count of days ***
                        TempDate := CALCDATE('<+1D>', LastFoundDate);
                        Found := TRUE;
                        REPEAT
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountDays += 1;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<+1D>', TempDate);
                            END ELSE
                                Found := FALSE;
                        UNTIL NOT Found;
                    END;
                    // *** find count of months ***
                    IF CountYears = 2 THEN BEGIN
                        TempDate := CALCDATE('<+1M>', LastFoundDate);
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountMonths := 1;
                            LastFoundDate := TempDate;
                            TempDate := CALCDATE('<2Y+2M-1D>', "Testing Period Starting Date");
                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                TempDate := CALCDATE('<2Y+2M>', "Testing Period Starting Date");
                            END;
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountMonths := 2;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<2Y+3M-1D>', "Testing Period Starting Date");
                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                    TempDate := CALCDATE('<2Y+3M>', "Testing Period Starting Date");
                                END;
                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                    CountMonths := 3;
                                    LastFoundDate := TempDate;
                                    TempDate := CALCDATE('<2Y+4M-1D>', "Testing Period Starting Date");
                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                        TempDate := CALCDATE('<2Y+4M>', "Testing Period Starting Date");
                                    END;
                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                        CountMonths := 4;
                                        LastFoundDate := TempDate;
                                        TempDate := CALCDATE('<2Y+5M-1D>', "Testing Period Starting Date");
                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                            TempDate := CALCDATE('<+2Y+5M>', "Testing Period Starting Date");
                                        END;
                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                            CountMonths := 5;
                                            LastFoundDate := TempDate;
                                            TempDate := CALCDATE('<2Y+6M-1D>', "Testing Period Starting Date");
                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                TempDate := CALCDATE('<2Y+6M>', "Testing Period Starting Date");
                                            END;
                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                CountMonths := 6;
                                                LastFoundDate := TempDate;
                                                TempDate := CALCDATE('<2Y+7M-1D>', "Testing Period Starting Date");
                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                    TempDate := CALCDATE('<2Y+7M>', "Testing Period Starting Date");
                                                END;
                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                    CountMonths := 7;
                                                    LastFoundDate := TempDate;
                                                    TempDate := CALCDATE('<2Y+8M-1D>', "Testing Period Starting Date");
                                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                        TempDate := CALCDATE('<2Y+8M>', "Testing Period Starting Date");
                                                    END;
                                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                        CountMonths := 8;
                                                        LastFoundDate := TempDate;
                                                        TempDate := CALCDATE('<2Y+9M+1D>', "Testing Period Starting Date");
                                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                            TempDate := CALCDATE('<+2Y+9M>', "Testing Period Starting Date");
                                                        END;
                                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                            CountMonths := 9;
                                                            LastFoundDate := TempDate;
                                                            TempDate := CALCDATE('<2Y+10M-1D>', "Testing Period Starting Date");
                                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                TempDate := CALCDATE('<2Y+10M>', "Testing Period Starting Date");
                                                            END;
                                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                CountMonths := 10;
                                                                LastFoundDate := TempDate;
                                                                TempDate := CALCDATE('<2Y+11M-1D>', "Testing Period Starting Date");
                                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                    TempDate := CALCDATE('<2Y+11M>', "Testing Period Starting Date");
                                                                END;
                                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                    CountMonths := 11;
                                                                    LastFoundDate := TempDate;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                        END;
                        // *** find count of days ***
                        TempDate := CALCDATE('<+1D>', LastFoundDate);
                        Found := TRUE;
                        REPEAT
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountDays += 1;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<+1D>', TempDate);
                            END ELSE
                                Found := FALSE;
                        UNTIL NOT Found;
                    END;
                    "Probation Days" := CountDays;
                    "Probation Months" := CountMonths;
                    "Probation Year" := CountYears;
                END
                ELSE BEGIN
                    "Probation Days" := 0;
                    "Probation Months" := 0;
                    "Probation Year" := 0;
                END;
                IF ("Testing Period Starting Date" = 0D) OR ("Testing Period Ending Date" = 0D) THEN BEGIN
                    "Probation Days" := 0;
                    "Probation Months" := 0;
                    "Probation Year" := 0;
                END;
                IF ("Probation Months" = 0) AND ("Probation Year" = 0) AND ("Testing Period Ending Date" <> 0D) AND ("Testing Period Starting Date" <> 0D) THEN BEGIN
                    TempDate := CALCDATE('<+1D>', "Testing Period Starting Date");
                    CountDays := 1;
                    Found := TRUE;
                    REPEAT
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountDays += 1;
                            LastFoundDate := TempDate;
                            TempDate := CALCDATE('<+1D>', TempDate);
                        END ELSE
                            Found := FALSE;
                    UNTIL NOT Found;
                    "Probation Days" := CountDays;
                END;

            end;
        }
        field(12; "Testing Period (Duration)"; DateFormula)
        {
            Caption = 'Testing Period (Duration)';
        }
        field(13; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Terminated';
            OptionMembers = Active,Terminated;
        }
        field(15; "Sector Code"; Code[20])
        {
            Caption = 'Sector Code';
        }
        field(17; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = false;

            trigger OnValidate()
            begin
                /***** provjera da li je krajnji datum veći od početnog *****/

                IF "Ending Date" <> 0D THEN BEGIN
                    IF "Starting Date" = 0D THEN
                        ERROR(Text000);
                    IF "Ending Date" < "Starting Date" THEN
                        ERROR(Text001);
                END;
                /***** provjera da li je krajnji datum veći od početnog *****/


                /***** provjera da li je krajnji datum pprethodnog ugovora veći od trenutnog *****/
                ECL.RESET;
                ECL.SETFILTER("Employee No.", '%1', "Employee No.");
                ECL.SETFILTER("No.", '<>%1', Rec."No.");
                ECL.SETFILTER("Starting Date", '<=%1', Rec."Starting Date");
                ECL.SETFILTER("Show Record", '%1', TRUE);
                ECL.SETCURRENTKEY("Starting Date");
                ECL.ASCENDING;
                IF ECL.FINDLAST THEN BEGIN
                    IF ECL."Ending Date" > "Starting Date" THEN MESSAGE(Text009);
                END;
                /***** provjera da li je krajnji datum pprethodnog ugovora veći od trenutnog *****/

                /***** validacija pozicije*****/
                IF (xRec."Starting Date" = 0D) AND (xRec."Position Description" = Rec."Position Description") THEN
                    VALIDATE("Position Description", Rec."Position Description");
                /***** validacija pozicije*****/

                IF "Starting Date" <= WORKDATE
                  THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                    ECL.SETFILTER("Starting Date", '>%1', Rec."Starting Date");
                    ECL.SETFILTER("Show Record", '%1', TRUE);
                    ECL.SETFILTER("No.", '<>%1', Rec."No.");
                    ECL.SETCURRENTKEY("Starting Date");
                    ECL.ASCENDING;
                    IF ECL.FINDLAST THEN BEGIN
                        IF ECL."Starting Date" > WORKDATE THEN BEGIN
                            VALIDATE(Active, TRUE);
                            Status := Status::Active;
                        END
                        ELSE BEGIN
                            VALIDATE(Active, FALSE);
                        END;
                    END
                    ELSE BEGIN
                        VALIDATE(Active, TRUE);
                        Status := Status::Active;
                        //ext
                        IF "Starting Date" <> 0D THEN BEGIN
                            IF ("Reason for Change" = "Reason for Change"::"New Contract") OR ("Reason for Change" = "Reason for Change"::Migration) THEN BEGIN
                                ECLExtern.RESET;
                                ECLExtern.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                                ECLExtern.SETFILTER("Reason for Change", '%1|%2', 1, 2);
                                ECLExtern.SETFILTER("Starting Date", '<%1', Rec."Starting Date");
                                ECLExtern.SETFILTER("Show Record", '%1', TRUE);
                                ECLExtern.SETFILTER("No.", '<>%1', Rec."No.");
                                ECLExtern.SETCURRENTKEY("Starting Date");
                                ECLExtern.ASCENDING;
                                IF ECLExtern.FINDLAST THEN BEGIN
                                    BeforePosition := ECLExtern."Position Description";
                                END;
                                ECL.RESET;
                                ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                                ECL.SETFILTER("No.", '<>%1', "No.");
                                ECL.SETFILTER("Starting Date", '<=%1', "Starting Date");
                                ECL.SETFILTER("Show Record", '%1', TRUE);
                                ECL.SETCURRENTKEY("Starting Date");
                                ECL.ASCENDING;
                                IF ECL.FINDLAST THEN BEGIN
                                    IF ECL."Engagement Type" = 'EXTERNI ANGAZMAN' THEN BEGIN
                                        ExternalDate.SETFILTER("Reason for Change", '%1|%2', "Reason for Change"::"New Contract", "Reason for Change"::Migration);
                                        ExternalDate.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                                        ExternalDate.SETFILTER("Starting Date", '<=%1', "Starting Date");
                                        ExternalDate.SETFILTER("Show Record", '%1', TRUE);
                                        ExternalDate.SETFILTER("Engagement Type", '%1', 'EXTERNI ANGAZMAN');
                                        ExternalDate.SETCURRENTKEY("Starting Date");
                                        ExternalDate.ASCENDING;
                                        IF ExternalDate.FINDLAST THEN BEGIN
                                            wb.RESET;
                                            wb.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                                            wb.SETFILTER("Contract Ledger Entry No.", '%1', ExternalDate."No.");
                                            wb.SETCURRENTKEY("Starting Date");
                                            IF wb.FINDLAST THEN BEGIN
                                                wb.VALIDATE("Current Company", FALSE);
                                                wb.VALIDATE("Ending Date", ECL."Ending Date");
                                                wb.Employer := '';
                                                wb.MODIFY(FALSE);
                                                HRSetup.GET;
                                                /*R_BroughtExperience.SetEmp("Employee No.");
                                                R_BroughtExperience.RUN;
                                                R_WorkExperience2.SetEmp("Employee No.",TODAY);
                                                R_WorkExperience2.RUN;*/
                                                IF ExternalDate."Engagement Type" <> HRSetup."External Description"
                                                 THEN BEGIN
                                                    R_BroughtExperience.SetEmp("Employee No.");
                                                END
                                                ELSE BEGIN
                                                    R_BroughtExperience.SetStatus("Employee No.", 'EXTERNAL', BeforePosition);
                                                    EksterniAngazman := TRUE;
                                                END;

                                                R_BroughtExperience.RUN;
                                                IF EksterniAngazman = TRUE THEN BEGIN
                                                    WBB.RESET;
                                                    WBB.SETFILTER("Contract Ledger Entry No.", '%1', ECLExtern."No.");
                                                    WBB.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                                                    WBB.SETCURRENTKEY("Starting Date");
                                                    WBB.ASCENDING;
                                                    IF WBB.FINDFIRST THEN BEGIN
                                                        IF ECLExtern."Position Description" <> 'IZVRŠILAC POSLA - DEKRA' THEN
                                                            WBB."Is not dekra" := TRUE
                                                        ELSE
                                                            WBB."Is dekra" := TRUE;
                                                        WBB.MODIFY;
                                                        R_BroughtExperience.SetStatus("Employee No.", 'EXTERNAL', BeforePosition);
                                                        R_BroughtExperience.RUN;
                                                    END;
                                                END;




                                                R_WorkExperience2.SetEmp("Employee No.", TODAY);
                                                R_WorkExperience2.RUN;




                                            END;
                                        END;
                                    END;
                                END;
                            END;
                        END;
                        // --------


                        Employee.RESET;
                        Employee.SETFILTER("No.", '%1', Rec."Employee No.");
                        IF Employee.FINDFIRST THEN BEGIN
                            IF Employee.StatusExt.AsInteger() < 3 THEN BEGIN
                                IF (Employee.StatusExt <> Employee.StatusExt::Unpaid) THEN BEGIN //
                                    Employee.VALIDATE(Status, Employee.StatusExt::Active);
                                END;

                            END
                            ELSE BEGIN

                                Employee.VALIDATE("External employer Status", Employee."External employer Status"::Active);
                            END;
                            Employee.MODIFY;
                        END;


                        Employee.RESET;
                        Employee.SETFILTER("No.", '%1', Rec."Employee No.");
                        IF Employee.FINDFIRST THEN BEGIN
                            HRSetup.GET;
                            IF Rec."Engagement Type" <> HRSetup."External Description" THEN BEGIN
                                IF (Employee.Status <> Employee.StatusExt::Unpaid) THEN BEGIN
                                    Employee.VALIDATE(Status, Employee.StatusExt::Active);
                                    Employee.VALIDATE("External employer Status", Employee."External employer Status"::" ");
                                    Employee.MODIFY;
                                END;
                            END;
                        END;



                        EmployeeContractLedger1.RESET;
                        EmployeeContractLedger1.SETFILTER("Employee No.", '%1', "Employee No.");
                        EmployeeContractLedger1.SETFILTER("No.", '<>%1', "No.");
                        EmployeeContractLedger1.SETFILTER("Show Record", '%1', TRUE);
                        IF EmployeeContractLedger1.FINDFIRST THEN BEGIN
                            REPEAT
                                EmployeeContractLedger1.Active := FALSE;

                                ORGShema.RESET;
                                ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Active);
                                IF ORGShema.FINDLAST THEN BEGIN
                                    IF EmployeeContractLedger1."Org. Structure" = ORGShema.Code THEN
                                        EmployeeContractLedger1.Status := 1;
                                END;
                                IF (EmployeeContractLedger1."Testing Period Successful" = EmployeeContractLedger1."Testing Period Successful"::" ") AND (EmployeeContractLedger1."Testing Period Ending Date" = CALCDATE('<-1D>', TODAY)) THEN BEGIN
                                    EmployeeContractLedger1."Testing Period Successful" := EmployeeContractLedger1."Testing Period Successful"::Yes;
                                END;
                                EmployeeContractLedger1.MODIFY;
                            UNTIL EmployeeContractLedger1.NEXT = 0;




                            ECLBefore2.RESET;
                            ECLBefore2.SETFILTER("No.", '<>%1', Rec."No.");
                            ECLBefore2.SETFILTER("Show Record", '%1', TRUE);
                            ECLBefore2.SETFILTER("Employee No.", '%1', "Employee No.");
                            ECLBefore2.SETFILTER("Ending Date", '%1', 0D);
                            ECLBefore2.SETCURRENTKEY("Starting Date");
                            ECLBefore2.ASCENDING;
                            IF ECLBefore2.FINDLAST THEN BEGIN
                                IF ((ECLBefore2."Ending Date" = 0D) AND (ECLBefore2."Starting Date" < "Starting Date"))
                            THEN
                                    ECLBefore2.VALIDATE("Ending Date", "Starting Date" - 1);
                                ECLBefore2.MODIFY;
                            END;


                            //NK2709 external END;
                            //NK2709 external END;
                            //NK2709 external END;
                        END;
                    END;
                END
                ELSE BEGIN
                    Rec.Status := Rec.Status::Terminated
                END;
                IF xRec."Starting Date" = 0D THEN BEGIN
                    //Rec.Status:=0;
                    EmployeeContractLedger1.RESET;
                    EmployeeContractLedger1.SETFILTER("Employee No.", "Employee No.");
                    EmployeeContractLedger1.SETFILTER("No.", '<>%1', "No.");
                    //EmployeeContractLedger1.SETFILTER("Ending Date",'%1',0D);
                    EmployeeContractLedger1.SETFILTER("Show Record", '%1', TRUE);
                    EmployeeContractLedger1.SETCURRENTKEY("Starting Date");
                    EmployeeContractLedger1.ASCENDING;
                    IF EmployeeContractLedger1.FINDLAST THEN BEGIN
                        IF ((EmployeeContractLedger1."Ending Date" = 0D) AND (EmployeeContractLedger1."Starting Date" < "Starting Date")) THEN
                            EmployeeContractLedger1.VALIDATE("Ending Date", "Starting Date" - 1);
                        EmployeeContractLedger1.MODIFY;
                    END;

                    /* ECLDate.SETFILTER("Employee No.",'%1',"Employee No.");
                     ECLDate.SETFILTER("No.",'<>%1',"No.");
                     ECLDate.SETFILTER("Ending Date",'%1',0D);
                     IF ECLDate.COUNT>=1 THEN BEGIN
                     IF ECLDate.FIND('+')
                     THEN ECLDate.VALIDATE("Ending Date","Starting Date"-1);
                     ECLDate.MODIFY;
                     END;*/

                END;




                /*IF ECL."Reason for Change"=ECL."Reason for Change"::"New Contract"
                THEN BEGIN
                ECL.SETFILTER( "Employee No.","Employee No.");
                      IF ECL.FINDLAST THEN BEGIN
                      Emp.RESET;
                      Emp.SETFILTER("No.","Employee No.");
                      IF Emp.FINDFIRST() THEN
                       BEGIN
                        Emp."Employment Date":="Starting Date";
                        Emp.MODIFY;
                       END;
                      END;
                      END;
                IF ECL."Reason for Change"=ECL."Reason for Change"::"New Contract" THEN
                "Registration Date":="Starting Date";*/
                IF "Reason for Change" = "Reason for Change"::"New Contract" THEN BEGIN
                    Emp.RESET;
                    Emp.SETFILTER("No.", "Employee No.");
                    IF Emp.FINDFIRST THEN BEGIN
                        Emp."Employment Date" := "Starting Date";
                        Emp.MODIFY;
                    END;
                END;

                IF "Reason for Change" = "Reason for Change"::"New Contract" THEN
                    "Registration Date" := "Starting Date";


                CALCFIELDS("Minimal Education Level");

                IF "Position Code" <> '' THEN BEGIN
                    IF "Starting Date" <> 0D THEN BEGIN
                        position.SETFILTER(Code, "Position Code");
                        position.SETFILTER(Description, '%1', "Position Description");
                        IF position.FINDFIRST THEN BEGIN
                            "Position Benef".RESET;
                            "Position Benef".SETFILTER("Position Code", '%1', "Position Code");
                            "Position Benef".SETFILTER("Position Name", '%1', "Position Description");
                            "Position Benef".SETFILTER("Org. Structure", '%1', "Org. Structure");
                            IF "Position Benef".FINDFIRST THEN BEGIN
                                REPEAT
                                    MAI2.RESET;
                                    MAI2.SETFILTER("Employee No.", '%1', "Employee No.");
                                    MAI2.SETFILTER("Position Code", '%1', "Position Code");
                                    MAI2.SETFILTER(Description, '%1', "Position Benef".Description);
                                    MAI2.SETFILTER(Amount, '%1', "Position Benef".Amount);
                                    MAI2.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', Rec."No.");
                                    MAI2.SETFILTER("Org Shema", '%1', "Org. Structure");
                                    IF NOT MAI2.FIND('-') THEN BEGIN
                                        MAI.INIT;
                                        MAI."Employee No." := "Employee No.";
                                        MAI."Position Code" := "Position Code";
                                        MAI."Misc. Article Code" := "Position Benef".Code;
                                        MAI.Description := "Position Benef".Description;
                                        MAI.Amount := "Position Benef".Amount;
                                        MAI."Emp. Contract Ledg. Entry No." := Rec."No.";
                                        MAI."From Date" := "Starting Date";
                                        MAI."Org Shema" := Rec."Org. Structure";
                                        MAI.INSERT;
                                    END;
                                UNTIL "Position Benef".NEXT = 0;
                            END
                        END;
                    END;
                END;

                /*nk 2709 External IF "Starting Date"<>0D THEN BEGIN
                IF "Reason for Change"="Reason for Change"::"New Contract" THEN BEGIN
                ECL.RESET;
                ECL.SETFILTER("Employee No.",'%1',Rec."Employee No.");
                ECL.SETFILTER("No.",'<>%1',"No.");
                ECL.SETFILTER("Starting Date",'<=%1',"Starting Date");
                ECL.SETFILTER("Show Record",'%1',TRUE);
                ECL.SETCURRENTKEY("Starting Date");
                ECL.ASCENDING;
                IF ECL.FINDLAST THEN BEGIN
                IF ECL."Engagement Type"='EXTERNI ANGAZMAN' THEN BEGIN
                wb.RESET;
                wb.SETFILTER("Employee No.",'%1',Rec."Employee No.");
                wb.SETFILTER("Contract Ledger Entry No.",'%1',ECL."No.");
                wb.SETCURRENTKEY("Starting Date");
                IF wb.FINDLAST THEN BEGIN
                wb.VALIDATE("Current Company",FALSE);
                wb.VALIDATE("Ending Date",ECL."Ending Date");
                wb.Employer:='';
                wb.MODIFY(FALSE);
                R_BroughtExperience.SetEmp("Employee No.");
                R_BroughtExperience.RUN;
                R_WorkExperience2.SetEmp("Employee No.",TODAY);
                R_WorkExperience2.RUN;
                
                 END;
                  END;
                   END; nk2709 ExternalDate*/
                IF (("Reason for Change" = "Reason for Change"::"New Contract")) THEN BEGIN
                    WorkBook.SETFILTER("Contract Ledger Entry No.", '%1', "No.");
                    IF NOT WorkBook.FINDFIRST THEN BEGIN
                        WorkBook.INIT;
                        IF WorkBook2.FINDLAST THEN
                            WorkBook."Contract No." := WorkBook2."Contract No." + 1;
                        WorkBook."Employee No." := "Employee No.";
                        WorkBook."Starting Date" := "Starting Date";
                        WorkBook."Ending Date" := TODAY;
                        WorkBook.VALIDATE("Current Company", TRUE);
                        Wagesetup.GET;
                        EmpOrg.RESET;
                        EmpOrg.SETFILTER("No.", '%1', Rec."Employee No.");
                        IF EmpOrg.FINDFIRST THEN
                            WorkBook.Coefficient := EmpOrg."Hours In Day" / Wagesetup."Hours in Day";
                        WorkBook."Contract Ledger Entry No." := "No.";

                        WorkBook.INSERT;
                        WorkBook.VALIDATE("Validate Work Experience", TRUE);
                        WorkBook.MODIFY(TRUE);
                        //nk 2709 External END;
                    END;
                    /*ELSE BEGIN
                    WorkBook.SETFILTER("Contract Ledger Entry No.",'%1',"No.");
                    IF WorkBook.FIND('-') THEN WorkBook.DELETE;

                    END;*/
                END;
                /***************NOVA VERZIJA*****************/
                /*********************************tRY**********************************/
                IF ("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI') THEN BEGIN
                    RecDate1.RESET;
                    RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                    RecDate1.SETRANGE("Period Start", "Starting Date", "Ending Date");
                    IF RecDate1.FINDSET THEN BEGIN
                        LastFoundDate1 := "Starting Date";
                        // *** find count of years ***
                        TempDate1 := CALCDATE('<+1Y-1D>', LastFoundDate1);
                        Found1 := TRUE;
                        CountYears1 := 0;
                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                            CountYears1 := 1;
                            LastFoundDate1 := TempDate1;
                            TempDate1 := CALCDATE('<+2Y-1D>', "Starting Date");
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountYears1 := 2;
                                LastFoundDate1 := TempDate1;
                            END;
                        END;

                        // *** find count of months ***
                        IF CountYears1 = 0 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M-1D>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<9M-1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        // *** find count of months ***
                        IF CountYears1 = 1 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<1Y+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<+1Y+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<1Y+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<1Y+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<1Y+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<1Y+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<1Y+5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+1Y+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<1Y+6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<1Y+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<1Y+7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<1Y+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<1Y+8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<+1Y+8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<1Y+9M+1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<1Y+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<1Y+10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<+1Y+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<1Y+11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<1Y+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        // *** find count of months ***
                        IF CountYears1 = 2 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<2Y+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<2Y+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<2Y+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<2Y+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<2Y+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<2Y+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<2Y+5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+2Y+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<2Y+6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<2Y+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<2Y+7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<2Y+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<2Y+8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<2Y+8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<2Y+9M+1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<+2Y+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<2Y+10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<2Y+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<2Y+11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<2Y+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        "Work Days" := CountDays1;
                        "Work Months" := CountMonths1;
                        "Work Years" := CountYears1;
                    END;
                END
                ELSE BEGIN
                    "Work Days" := 0;
                    "Work Months" := 0;
                    "Work Years" := 0;
                END;
                IF ("Starting Date" = 0D) OR ("Ending Date" = 0D) THEN BEGIN
                    "Work Days" := 0;
                    "Work Months" := 0;
                    "Work Years" := 0;
                END;
                IF ("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI') THEN BEGIN
                    IF
                    ("Work Months" = 0) AND ("Work Years" = 0) AND ("Ending Date" <> 0D) AND ("Starting Date" <> 0D) THEN BEGIN
                        CountDays1 := 1;
                        TempDate1 := CALCDATE('<+1D>', "Starting Date");
                        Found1 := TRUE;
                        REPEAT
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountDays1 += 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<+1D>', TempDate1);
                            END ELSE
                                Found1 := FALSE;
                        UNTIL NOT Found1;
                        "Work Days" := CountDays1;
                    END;
                END;
                EngagementType.RESET;
                EngagementType.SETFILTER(Description, '%1', Rec."Engagement Type");
                IF EngagementType.FINDFIRST THEN BEGIN
                    IF (EngagementType.Code = '5') OR (EngagementType.Code = '2') THEN BEGIN
                        "Testing Period" := TRUE;
                        "Testing Period Starting Date" := "Starting Date";
                    END
                    ELSE BEGIN
                        "Testing Period" := FALSE;
                        "Testing Period Starting Date" := 0D;
                    END;
                END;

                IF Rec.Active = TRUE THEN BEGIN

                    EmployeeDefaultDimension.INIT;
                    EmployeeDefaultDimension."No." := Rec."Employee No.";
                    EmployeeDefaultDimension.VALIDATE("No.", Rec."Employee No.");
                    EmployeeDefaultDimension.VALIDATE("Dimension Code", 'TC');
                    EmployeeDefaultDimension."Amount Distribution Coeff." := 1;
                    DimensionForPosition.RESET;
                    DimensionForPosition.SETFILTER("Sector  Description", '%1', "Sector Description");
                    DimensionForPosition.SETFILTER("Department Categ.  Description", '%1', "Department Cat. Description");
                    DimensionForPosition.SETFILTER("Group Description", '%1', "Group Description");
                    DimensionForPosition.SETFILTER("Team Description", '%1', "Team Description");
                    DimensionForPosition.SETFILTER("Position Description", '%1', "Position Description");
                    DimensionForPosition.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    IF DimensionForPosition.FINDFIRST THEN BEGIN

                        EmployeeDefaultDimension.RESET;
                        EmployeeDefaultDimension.SETFILTER("No.", '%1', "Employee No.");
                        IF EmployeeDefaultDimension.FINDFIRST THEN
                            EmployeeDefaultDimension.DELETE;

                        EmployeeDefaultDimension.VALIDATE("Dimension Value Code", DimensionForPosition."Dimension Value Code");
                        EmployeeDefaultDimension.INSERT;
                    END;
                END;
                IF (xRec."Starting Date" <> Rec."Starting Date") OR (xRec."Ending Date" <> Rec."Ending Date") THEN BEGIN

                    IF Rec."Reason for Change" = Rec."Reason for Change"::"New Contract" THEN BEGIN

                        WbMod.RESET;
                        WbMod.SETFILTER("Current Company", '%1', TRUE);
                        WbMod.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        WbMod.SETFILTER("Contract Ledger Entry No.", '<>%1', Rec."No.");
                        WbMod.SETCURRENTKEY("Starting Date");
                        WbMod.ASCENDING;
                        IF WbMod.FINDLAST THEN BEGIN
                            ECLRec2.RESET;
                            ECLRec2.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            ECLRec2.SETFILTER("Starting Date", '<%1', Rec."Starting Date");
                            ECLRec2.SETFILTER("Show Record", '%1', TRUE);
                            ECLRec2.SETFILTER("Engagement Type", '<>%1', 'MIROVANJE');
                            ECLRec2.SETCURRENTKEY("Starting Date");
                            ECLRec2.ASCENDING;
                            IF ECLRec2.FINDLAST THEN BEGIN
                                WbMod."Ending Date" := ECLRec2."Ending Date";
                                WbMod.MODIFY;
                            END;
                        END;
                    END
                    ELSE BEGIN
                        ECLRec.RESET;
                        ECLRec.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        ECLRec.SETCURRENTKEY("Starting Date");
                        ECLRec.SETFILTER("Reason for Change", '<>%1', ECLRec."Reason for Change"::"New Contract");
                        ECLRec.ASCENDING;
                        IF ECLRec.FINDLAST THEN BEGIN
                            ECLRec2.RESET;
                            ECLRec2.SETFILTER("Reason for Change", '%1', ECLRec2."Reason for Change"::"New Contract");
                            ECLRec2.SETFILTER("Employee No.", '%1', ECLRec."Employee No.");
                            ECLRec2.SETCURRENTKEY("Starting Date");
                            ECLRec2.ASCENDING;
                            IF ECLRec2.FINDFIRST THEN BEGIN
                                WbMod.RESET;
                                WbMod.SETFILTER("Contract Ledger Entry No.", '<>%1', ECLRec2."No.");
                                WbMod.SETFILTER("Employee No.", '%1', ECLRec."Employee No.");
                                WbMod.SETFILTER("Current Company", '%1', TRUE);
                                WbMod.SETCURRENTKEY("Starting Date");
                                WbMod.ASCENDING;
                                IF WbMod.FINDLAST THEN BEGIN
                                    WbMod."Ending Date" := ECLRec."Ending Date";
                                    WbMod.MODIFY;
                                END;
                            END;

                        END;


                    END;
                END;
                //END;
                IF ("Reason for Change" = 3) OR ("Reason for Change" = 7) OR ("Reason for Change" = 8) OR ("Reason for Change" = 9) OR ("Reason for Change" = 10)
             OR ("Reason for Change" = 12) OR ("Reason for Change" = 4) OR ("Reason for Change" = 11) OR ("Reason for Change" = 15) OR ("Reason for Change" = 16)
             THEN BEGIN
                    StavkeUgovora.RESET;
                    StavkeUgovora.SETFILTER("Show Record", '%1', TRUE);
                    StavkeUgovora.SETFILTER("Starting Date", '<%1', Rec."Starting Date");
                    StavkeUgovora.SETCURRENTKEY("Starting Date");
                    StavkeUgovora.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                    IF StavkeUgovora.FINDLAST THEN BEGIN
                        StavkeUgovora."Org Modification Date" := "Starting Date";
                        StavkeUgovora.MODIFY;
                    END;

                END;
                IF ("Starting Date" <> 0D) AND ("Show Record" = TRUE) AND (Rec."No." <> 0) THEN
                    Maticna.EmployeeContractLedger2(xRec, Rec);

            end;
        }
        field(18; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin

                IF "Ending Date" <> 0D THEN BEGIN
                    IF "Starting Date" = 0D THEN
                        ERROR(Text000);
                    IF "Ending Date" < "Starting Date" THEN
                        ERROR(Text001);
                END;


                EngagementType.RESET;
                EngagementType.SETFILTER(Description, '%1', Rec."Engagement Type");
                IF EngagementType.FINDFIRST THEN BEGIN
                    IF (EngagementType.Code = '5') OR (EngagementType.Code = '2') THEN BEGIN

                        "Testing Period" := TRUE;
                        "Testing Period Starting Date" := "Starting Date";
                    END
                    ELSE BEGIN
                        "Testing Period" := FALSE;
                        "Testing Period Starting Date" := 0D;
                    END;
                END;

                /*********************************tRY**********************************/
                /*********************************tRY**********************************/
                IF ("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI') THEN BEGIN
                    RecDate1.RESET;
                    RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                    RecDate1.SETRANGE("Period Start", "Starting Date", "Ending Date");
                    IF RecDate1.FINDSET THEN BEGIN
                        LastFoundDate1 := "Starting Date";
                        // *** find count of years ***
                        TempDate1 := CALCDATE('<+1Y-1D>', LastFoundDate1);
                        Found1 := TRUE;
                        CountYears1 := 0;
                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                            CountYears1 := 1;
                            LastFoundDate1 := TempDate1;
                            TempDate1 := CALCDATE('<+2Y-1D>', "Starting Date");
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountYears1 := 2;
                                LastFoundDate1 := TempDate1;
                            END;
                        END;

                        // *** find count of months ***
                        IF CountYears1 = 0 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M-1D>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<9M-1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        // *** find count of months ***
                        IF CountYears1 = 1 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<1Y+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<+1Y+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<1Y+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<1Y+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<1Y+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<1Y+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<1Y+5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+1Y+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<1Y+6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<1Y+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<1Y+7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<1Y+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<1Y+8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<+1Y+8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<1Y+9M+1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<1Y+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<1Y+10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<+1Y+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<1Y+11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<1Y+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        // *** find count of months ***
                        IF CountYears1 = 2 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<2Y+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<2Y+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<2Y+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<2Y+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<2Y+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<2Y+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<2Y+5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+2Y+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<2Y+6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<2Y+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<2Y+7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<2Y+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<2Y+8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<2Y+8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<2Y+9M+1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<+2Y+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<2Y+10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<2Y+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<2Y+11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<2Y+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        "Work Days" := CountDays1;
                        "Work Months" := CountMonths1;
                        "Work Years" := CountYears1;
                    END;
                END
                ELSE BEGIN
                    "Work Days" := 0;
                    "Work Months" := 0;
                    "Work Years" := 0;
                END;
                IF ("Starting Date" = 0D) OR ("Ending Date" = 0D) THEN BEGIN
                    "Work Days" := 0;
                    "Work Months" := 0;
                    "Work Years" := 0;
                END;
                IF ("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI') THEN BEGIN
                    IF
                    ("Work Months" = 0) AND ("Work Years" = 0) AND ("Ending Date" <> 0D) AND ("Starting Date" <> 0D) THEN BEGIN
                        CountDays1 := 1;
                        TempDate1 := CALCDATE('<+1D>', "Starting Date");
                        Found1 := TRUE;
                        REPEAT
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountDays1 += 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<+1D>', TempDate1);
                            END ELSE
                                Found1 := FALSE;
                        UNTIL NOT Found1;
                        "Work Days" := CountDays1;
                    END;
                END;
                IF Rec."Grounds for Term. Description" <> '' THEN BEGIN
                    wb.RESET;
                    wb.SETFILTER("Contract Ledger Entry No.", '%1', Rec."No.");
                    IF wb.FINDFIRST THEN BEGIN
                        IF wb."Ending Date" <> Rec."Ending Date" THEN BEGIN
                            wb.VALIDATE("Ending Date", Rec."Ending Date");
                            wb.MODIFY;
                        END;
                    END;
                END;
                IF ((Rec."Ending Date" <> 0D) AND (Rec."Ending Date" < WORKDATE)) THEN
                    VALIDATE(Active, FALSE);
                IF ((Rec."Ending Date" >= WORKDATE) AND (Rec."Starting Date" <= WORKDATE)) THEN
                    VALIDATE(Active, TRUE);

            end;
        }
        field(23; Previous; Boolean)
        {
        }
        field(24; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
        }
        field(25; "First Time Employed"; Boolean)
        {
            Caption = 'First Time Employed';
        }
        field(26; Tax; Decimal)
        {
            Caption = 'Tax';
        }
        field(27; "Tax Deduction Amount"; Decimal)
        {
            Caption = 'Tax Deduction Amount';
        }
        field(28; "Brutto After Contributtion"; Decimal)
        {
            Caption = 'Brutto After Contributtion';
        }
        field(29; "Employee Name"; Text[81])
        {
            Caption = 'Employee Name';
            Editable = true;
        }
        field(30; "Testing Period Successful"; Option)
        {
            Caption = 'Testing Period Successful';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(31; "Wage Type"; Option)
        {
            Caption = 'Wage Type';
            FieldClass = Normal;
            OptionCaption = ' ,Brutto,Netto';
            OptionMembers = " ",Brutto,Netto;
        }
        field(32; "Way of Employment"; Option)
        {
            Caption = 'Way of Employment';
            OptionCaption = ' ,Employment Office,Longer Redundancy,From Employment,Court Ruling,Dekra';
            OptionMembers = " ","Employment Office","Longer Redundancy","From Employment","Court Ruling",Dekra;
        }
        field(33; Prentice; Boolean)
        {
            Caption = 'Prentice';
        }
        field(34; KPI; Boolean)
        {
            Caption = 'KPI';
        }
        field(35; "Testing Period Starting Date"; Date)
        {
            Caption = 'Testing Period Starting Date';

            trigger OnValidate()
            begin
                //AJ
                IF "Testing Period Ending Date" <> 0D THEN BEGIN
                    IF "Testing Period Starting Date" = 0D THEN
                        ERROR(Text000);
                    IF "Testing Period Ending Date" < "Testing Period Starting Date" THEN
                        ERROR(Text001);
                END;
                /***************NOVA VERZIJA*****************/
                /*********************************tRY**********************************/
                RecDate.RESET;
                RecDate.SETRANGE("Period Type", RecDate."Period Type"::Date);
                RecDate.SETRANGE("Period Start", "Testing Period Starting Date", "Testing Period Ending Date");
                IF RecDate.FINDSET THEN BEGIN
                    LastFoundDate := "Testing Period Starting Date";
                    // *** find count of years ***
                    TempDate := CALCDATE('<+1Y-1D>', LastFoundDate);
                    Found := TRUE;
                    CountYears := 0;
                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                        CountYears := 1;
                        LastFoundDate := TempDate;
                        TempDate := CALCDATE('<+2Y-1D>', "Testing Period Starting Date");
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountYears := 2;
                            LastFoundDate := TempDate;
                        END;
                    END;

                    // *** find count of months ***
                    IF CountYears = 0 THEN BEGIN
                        TempDate := CALCDATE('<+1M-1D>', LastFoundDate);
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountMonths := 1;
                            LastFoundDate := TempDate;
                            TempDate := CALCDATE('<+2M-1D>', "Testing Period Starting Date");
                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                TempDate := CALCDATE('<+2M>', "Testing Period Starting Date");
                            END;
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountMonths := 2;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<+3M-1D>', "Testing Period Starting Date");
                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                    TempDate := CALCDATE('<+3M>', "Testing Period Starting Date");
                                END;
                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                    CountMonths := 3;
                                    LastFoundDate := TempDate;
                                    TempDate := CALCDATE('<+4M-1D>', "Testing Period Starting Date");
                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                        TempDate := CALCDATE('<+4M>', "Testing Period Starting Date");
                                    END;
                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                        CountMonths := 4;
                                        LastFoundDate := TempDate;
                                        TempDate := CALCDATE('<5M-1D>', "Testing Period Starting Date");
                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                            TempDate := CALCDATE('<+5M>', "Testing Period Starting Date");
                                        END;
                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                            CountMonths := 5;
                                            LastFoundDate := TempDate;
                                            TempDate := CALCDATE('<6M-1D>', "Testing Period Starting Date");
                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                TempDate := CALCDATE('<+6M>', "Testing Period Starting Date");
                                            END;
                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                CountMonths := 6;
                                                LastFoundDate := TempDate;
                                                TempDate := CALCDATE('<7M-1D>', "Testing Period Starting Date");
                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                    TempDate := CALCDATE('<+7M>', "Testing Period Starting Date");
                                                END;
                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                    CountMonths := 7;
                                                    LastFoundDate := TempDate;
                                                    TempDate := CALCDATE('<8M-1D>', "Testing Period Starting Date");
                                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                        TempDate := CALCDATE('<8M>', "Testing Period Starting Date");
                                                    END;
                                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                        CountMonths := 8;
                                                        LastFoundDate := TempDate;
                                                        TempDate := CALCDATE('<9M-1D>', "Testing Period Starting Date");
                                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                            TempDate := CALCDATE('<+9M>', "Testing Period Starting Date");
                                                        END;
                                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                            CountMonths := 9;
                                                            LastFoundDate := TempDate;
                                                            TempDate := CALCDATE('<10M-1D>', "Testing Period Starting Date");
                                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                TempDate := CALCDATE('<+10M>', "Testing Period Starting Date");
                                                            END;
                                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                CountMonths := 10;
                                                                LastFoundDate := TempDate;
                                                                TempDate := CALCDATE('<11M-1D>', "Testing Period Starting Date");
                                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                    TempDate := CALCDATE('<+11M>', "Testing Period Starting Date");
                                                                END;
                                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                    CountMonths := 11;
                                                                    LastFoundDate := TempDate;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                        END;
                        // *** find count of days ***
                        TempDate := CALCDATE('<+1D>', LastFoundDate);
                        Found := TRUE;
                        REPEAT
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountDays += 1;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<+1D>', TempDate);
                            END ELSE
                                Found := FALSE;
                        UNTIL NOT Found;
                    END;
                    // *** find count of months ***
                    IF CountYears = 1 THEN BEGIN
                        TempDate := CALCDATE('<+1M>', LastFoundDate);
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountMonths := 1;
                            LastFoundDate := TempDate;
                            TempDate := CALCDATE('<1Y+2M-1D>', "Testing Period Starting Date");
                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                TempDate := CALCDATE('<+1Y+2M>', "Testing Period Starting Date");
                            END;
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountMonths := 2;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<1Y+3M-1D>', "Testing Period Starting Date");
                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                    TempDate := CALCDATE('<1Y+3M>', "Testing Period Starting Date");
                                END;
                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                    CountMonths := 3;
                                    LastFoundDate := TempDate;
                                    TempDate := CALCDATE('<1Y+4M-1D>', "Testing Period Starting Date");
                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                        TempDate := CALCDATE('<1Y+4M>', "Testing Period Starting Date");
                                    END;
                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                        CountMonths := 4;
                                        LastFoundDate := TempDate;
                                        TempDate := CALCDATE('<1Y+5M-1D>', "Testing Period Starting Date");
                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                            TempDate := CALCDATE('<+1Y+5M>', "Testing Period Starting Date");
                                        END;
                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                            CountMonths := 5;
                                            LastFoundDate := TempDate;
                                            TempDate := CALCDATE('<1Y+6M-1D>', "Testing Period Starting Date");
                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                TempDate := CALCDATE('<1Y+6M>', "Testing Period Starting Date");
                                            END;
                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                CountMonths := 6;
                                                LastFoundDate := TempDate;
                                                TempDate := CALCDATE('<1Y+7M-1D>', "Testing Period Starting Date");
                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                    TempDate := CALCDATE('<1Y+7M>', "Testing Period Starting Date");
                                                END;
                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                    CountMonths := 7;
                                                    LastFoundDate := TempDate;
                                                    TempDate := CALCDATE('<1Y+8M-1D>', "Testing Period Starting Date");
                                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                        TempDate := CALCDATE('<+1Y+8M>', "Testing Period Starting Date");
                                                    END;
                                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                        CountMonths := 8;
                                                        LastFoundDate := TempDate;
                                                        TempDate := CALCDATE('<1Y+9M+1D>', "Testing Period Starting Date");
                                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                            TempDate := CALCDATE('<1Y+9M>', "Testing Period Starting Date");
                                                        END;
                                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                            CountMonths := 9;
                                                            LastFoundDate := TempDate;
                                                            TempDate := CALCDATE('<1Y+10M-1D>', "Testing Period Starting Date");
                                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                TempDate := CALCDATE('<+1Y+10M>', "Testing Period Starting Date");
                                                            END;
                                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                CountMonths := 10;
                                                                LastFoundDate := TempDate;
                                                                TempDate := CALCDATE('<1Y+11M-1D>', "Testing Period Starting Date");
                                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                    TempDate := CALCDATE('<1Y+11M>', "Testing Period Starting Date");
                                                                END;
                                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                    CountMonths := 11;
                                                                    LastFoundDate := TempDate;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                        END;
                        // *** find count of days ***
                        TempDate := CALCDATE('<+1D>', LastFoundDate);
                        Found := TRUE;
                        REPEAT
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountDays += 1;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<+1D>', TempDate);
                            END ELSE
                                Found := FALSE;
                        UNTIL NOT Found;
                    END;
                    // *** find count of months ***
                    IF CountYears = 2 THEN BEGIN
                        TempDate := CALCDATE('<+1M>', LastFoundDate);
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountMonths := 1;
                            LastFoundDate := TempDate;
                            TempDate := CALCDATE('<2Y+2M-1D>', "Testing Period Starting Date");
                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                TempDate := CALCDATE('<2Y+2M>', "Testing Period Starting Date");
                            END;
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountMonths := 2;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<2Y+3M-1D>', "Testing Period Starting Date");
                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                    TempDate := CALCDATE('<2Y+3M>', "Testing Period Starting Date");
                                END;
                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                    CountMonths := 3;
                                    LastFoundDate := TempDate;
                                    TempDate := CALCDATE('<2Y+4M-1D>', "Testing Period Starting Date");
                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                        TempDate := CALCDATE('<2Y+4M>', "Testing Period Starting Date");
                                    END;
                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                        CountMonths := 4;
                                        LastFoundDate := TempDate;
                                        TempDate := CALCDATE('<2Y+5M-1D>', "Testing Period Starting Date");
                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                            TempDate := CALCDATE('<+2Y+5M>', "Testing Period Starting Date");
                                        END;
                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                            CountMonths := 5;
                                            LastFoundDate := TempDate;
                                            TempDate := CALCDATE('<2Y+6M-1D>', "Testing Period Starting Date");
                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                TempDate := CALCDATE('<2Y+6M>', "Testing Period Starting Date");
                                            END;
                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                CountMonths := 6;
                                                LastFoundDate := TempDate;
                                                TempDate := CALCDATE('<2Y+7M-1D>', "Testing Period Starting Date");
                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                    TempDate := CALCDATE('<2Y+7M>', "Testing Period Starting Date");
                                                END;
                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                    CountMonths := 7;
                                                    LastFoundDate := TempDate;
                                                    TempDate := CALCDATE('<2Y+8M-1D>', "Testing Period Starting Date");
                                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                        TempDate := CALCDATE('<2Y+8M>', "Testing Period Starting Date");
                                                    END;
                                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                        CountMonths := 8;
                                                        LastFoundDate := TempDate;
                                                        TempDate := CALCDATE('<2Y+9M+1D>', "Testing Period Starting Date");
                                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                            TempDate := CALCDATE('<+2Y+9M>', "Testing Period Starting Date");
                                                        END;
                                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                            CountMonths := 9;
                                                            LastFoundDate := TempDate;
                                                            TempDate := CALCDATE('<2Y+10M-1D>', "Testing Period Starting Date");
                                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                TempDate := CALCDATE('<2Y+10M>', "Testing Period Starting Date");
                                                            END;
                                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                CountMonths := 10;
                                                                LastFoundDate := TempDate;
                                                                TempDate := CALCDATE('<2Y+11M-1D>', "Testing Period Starting Date");
                                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                    TempDate := CALCDATE('<2Y+11M>', "Testing Period Starting Date");
                                                                END;
                                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                    CountMonths := 11;
                                                                    LastFoundDate := TempDate;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                        END;
                        // *** find count of days ***
                        TempDate := CALCDATE('<+1D>', LastFoundDate);
                        Found := TRUE;
                        REPEAT
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountDays += 1;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<+1D>', TempDate);
                            END ELSE
                                Found := FALSE;
                        UNTIL NOT Found;
                    END;
                    "Probation Days" := CountDays;
                    "Probation Months" := CountMonths;
                    "Probation Year" := CountYears;
                END
                ELSE BEGIN
                    "Probation Days" := 0;
                    "Probation Months" := 0;
                    "Probation Year" := 0;
                END;
                IF ("Testing Period Starting Date" = 0D) OR ("Testing Period Ending Date" = 0D) THEN BEGIN
                    "Probation Days" := 0;
                    "Probation Months" := 0;
                    "Probation Year" := 0;
                END;
                IF ("Probation Months" = 0) AND ("Probation Year" = 0) AND ("Testing Period Ending Date" <> 0D) AND ("Testing Period Starting Date" <> 0D) THEN BEGIN
                    TempDate := CALCDATE('<+1D>', "Testing Period Starting Date");
                    CountDays := 1;
                    Found := TRUE;
                    REPEAT
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountDays += 1;
                            LastFoundDate := TempDate;
                            TempDate := CALCDATE('<+1D>', TempDate);
                        END ELSE
                            Found := FALSE;
                    UNTIL NOT Found;
                    "Probation Days" := CountDays;
                END;

            end;
        }
        field(36; "Testing Period Ending Date"; Date)
        {
            Caption = 'Testing Period Ending Date';

            trigger OnValidate()
            begin
                //AJ
                IF "Testing Period Ending Date" <> 0D THEN BEGIN
                    IF "Testing Period Starting Date" = 0D THEN
                        ERROR(Text000);
                    IF "Testing Period Ending Date" < "Testing Period Starting Date" THEN
                        ERROR(Text001);
                END;
                /***************NOVA VERZIJA*****************/
                /*********************************tRY**********************************/
                RecDate.RESET;
                RecDate.SETRANGE("Period Type", RecDate."Period Type"::Date);
                RecDate.SETRANGE("Period Start", "Testing Period Starting Date", "Testing Period Ending Date");
                IF RecDate.FINDSET THEN BEGIN
                    LastFoundDate := "Testing Period Starting Date";
                    // *** find count of years ***
                    TempDate := CALCDATE('<+1Y-1D>', LastFoundDate);
                    Found := TRUE;
                    CountYears := 0;
                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                        CountYears := 1;
                        LastFoundDate := TempDate;
                        TempDate := CALCDATE('<+2Y-1D>', "Testing Period Starting Date");
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountYears := 2;
                            LastFoundDate := TempDate;
                        END;
                    END;

                    // *** find count of months ***
                    IF CountYears = 0 THEN BEGIN
                        TempDate := CALCDATE('<+1M-1D>', LastFoundDate);
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountMonths := 1;
                            LastFoundDate := TempDate;
                            TempDate := CALCDATE('<+2M-1D>', "Testing Period Starting Date");
                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                TempDate := CALCDATE('<+2M>', "Testing Period Starting Date");
                            END;
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountMonths := 2;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<+3M-1D>', "Testing Period Starting Date");
                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                    TempDate := CALCDATE('<+3M>', "Testing Period Starting Date");
                                END;
                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                    CountMonths := 3;
                                    LastFoundDate := TempDate;
                                    TempDate := CALCDATE('<+4M-1D>', "Testing Period Starting Date");
                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                        TempDate := CALCDATE('<+4M>', "Testing Period Starting Date");
                                    END;
                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                        CountMonths := 4;
                                        LastFoundDate := TempDate;
                                        TempDate := CALCDATE('<5M-1D>', "Testing Period Starting Date");
                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                            TempDate := CALCDATE('<+5M>', "Testing Period Starting Date");
                                        END;
                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                            CountMonths := 5;
                                            LastFoundDate := TempDate;
                                            TempDate := CALCDATE('<6M-1D>', "Testing Period Starting Date");
                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                TempDate := CALCDATE('<+6M>', "Testing Period Starting Date");
                                            END;
                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                CountMonths := 6;
                                                LastFoundDate := TempDate;
                                                TempDate := CALCDATE('<7M-1D>', "Testing Period Starting Date");
                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                    TempDate := CALCDATE('<+7M>', "Testing Period Starting Date");
                                                END;
                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                    CountMonths := 7;
                                                    LastFoundDate := TempDate;
                                                    TempDate := CALCDATE('<8M-1D>', "Testing Period Starting Date");
                                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                        TempDate := CALCDATE('<8M>', "Testing Period Starting Date");
                                                    END;
                                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                        CountMonths := 8;
                                                        LastFoundDate := TempDate;
                                                        TempDate := CALCDATE('<9M-1D>', "Testing Period Starting Date");
                                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                            TempDate := CALCDATE('<+9M>', "Testing Period Starting Date");
                                                        END;
                                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                            CountMonths := 9;
                                                            LastFoundDate := TempDate;
                                                            TempDate := CALCDATE('<10M-1D>', "Testing Period Starting Date");
                                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                TempDate := CALCDATE('<+10M>', "Testing Period Starting Date");
                                                            END;
                                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                CountMonths := 10;
                                                                LastFoundDate := TempDate;
                                                                TempDate := CALCDATE('<11M-1D>', "Testing Period Starting Date");
                                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                    TempDate := CALCDATE('<+11M>', "Testing Period Starting Date");
                                                                END;
                                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                    CountMonths := 11;
                                                                    LastFoundDate := TempDate;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                        END;
                        // *** find count of days ***
                        TempDate := CALCDATE('<+1D>', LastFoundDate);
                        Found := TRUE;
                        REPEAT
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountDays += 1;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<+1D>', TempDate);
                            END ELSE
                                Found := FALSE;
                        UNTIL NOT Found;
                    END;
                    // *** find count of months ***
                    IF CountYears = 1 THEN BEGIN
                        TempDate := CALCDATE('<+1M>', LastFoundDate);
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountMonths := 1;
                            LastFoundDate := TempDate;
                            TempDate := CALCDATE('<1Y+2M-1D>', "Testing Period Starting Date");
                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                TempDate := CALCDATE('<+1Y+2M>', "Testing Period Starting Date");
                            END;
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountMonths := 2;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<1Y+3M-1D>', "Testing Period Starting Date");
                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                    TempDate := CALCDATE('<1Y+3M>', "Testing Period Starting Date");
                                END;
                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                    CountMonths := 3;
                                    LastFoundDate := TempDate;
                                    TempDate := CALCDATE('<1Y+4M-1D>', "Testing Period Starting Date");
                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                        TempDate := CALCDATE('<1Y+4M>', "Testing Period Starting Date");
                                    END;
                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                        CountMonths := 4;
                                        LastFoundDate := TempDate;
                                        TempDate := CALCDATE('<1Y+5M-1D>', "Testing Period Starting Date");
                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                            TempDate := CALCDATE('<+1Y+5M>', "Testing Period Starting Date");
                                        END;
                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                            CountMonths := 5;
                                            LastFoundDate := TempDate;
                                            TempDate := CALCDATE('<1Y+6M-1D>', "Testing Period Starting Date");
                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                TempDate := CALCDATE('<1Y+6M>', "Testing Period Starting Date");
                                            END;
                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                CountMonths := 6;
                                                LastFoundDate := TempDate;
                                                TempDate := CALCDATE('<1Y+7M-1D>', "Testing Period Starting Date");
                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                    TempDate := CALCDATE('<1Y+7M>', "Testing Period Starting Date");
                                                END;
                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                    CountMonths := 7;
                                                    LastFoundDate := TempDate;
                                                    TempDate := CALCDATE('<1Y+8M-1D>', "Testing Period Starting Date");
                                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                        TempDate := CALCDATE('<+1Y+8M>', "Testing Period Starting Date");
                                                    END;
                                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                        CountMonths := 8;
                                                        LastFoundDate := TempDate;
                                                        TempDate := CALCDATE('<1Y+9M+1D>', "Testing Period Starting Date");
                                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                            TempDate := CALCDATE('<1Y+9M>', "Testing Period Starting Date");
                                                        END;
                                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                            CountMonths := 9;
                                                            LastFoundDate := TempDate;
                                                            TempDate := CALCDATE('<1Y+10M-1D>', "Testing Period Starting Date");
                                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                TempDate := CALCDATE('<+1Y+10M>', "Testing Period Starting Date");
                                                            END;
                                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                CountMonths := 10;
                                                                LastFoundDate := TempDate;
                                                                TempDate := CALCDATE('<1Y+11M-1D>', "Testing Period Starting Date");
                                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                    TempDate := CALCDATE('<1Y+11M>', "Testing Period Starting Date");
                                                                END;
                                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                    CountMonths := 11;
                                                                    LastFoundDate := TempDate;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                        END;
                        // *** find count of days ***
                        TempDate := CALCDATE('<+1D>', LastFoundDate);
                        Found := TRUE;
                        REPEAT
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountDays += 1;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<+1D>', TempDate);
                            END ELSE
                                Found := FALSE;
                        UNTIL NOT Found;
                    END;
                    // *** find count of months ***
                    IF CountYears = 2 THEN BEGIN
                        TempDate := CALCDATE('<+1M>', LastFoundDate);
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountMonths := 1;
                            LastFoundDate := TempDate;
                            TempDate := CALCDATE('<2Y+2M-1D>', "Testing Period Starting Date");
                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                TempDate := CALCDATE('<2Y+2M>', "Testing Period Starting Date");
                            END;
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountMonths := 2;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<2Y+3M-1D>', "Testing Period Starting Date");
                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                    TempDate := CALCDATE('<2Y+3M>', "Testing Period Starting Date");
                                END;
                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                    CountMonths := 3;
                                    LastFoundDate := TempDate;
                                    TempDate := CALCDATE('<2Y+4M-1D>', "Testing Period Starting Date");
                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                        TempDate := CALCDATE('<2Y+4M>', "Testing Period Starting Date");
                                    END;
                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                        CountMonths := 4;
                                        LastFoundDate := TempDate;
                                        TempDate := CALCDATE('<2Y+5M-1D>', "Testing Period Starting Date");
                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                            TempDate := CALCDATE('<+2Y+5M>', "Testing Period Starting Date");
                                        END;
                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                            CountMonths := 5;
                                            LastFoundDate := TempDate;
                                            TempDate := CALCDATE('<2Y+6M-1D>', "Testing Period Starting Date");
                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                TempDate := CALCDATE('<2Y+6M>', "Testing Period Starting Date");
                                            END;
                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                CountMonths := 6;
                                                LastFoundDate := TempDate;
                                                TempDate := CALCDATE('<2Y+7M-1D>', "Testing Period Starting Date");
                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                    TempDate := CALCDATE('<2Y+7M>', "Testing Period Starting Date");
                                                END;
                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                    CountMonths := 7;
                                                    LastFoundDate := TempDate;
                                                    TempDate := CALCDATE('<2Y+8M-1D>', "Testing Period Starting Date");
                                                    IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                        TempDate := CALCDATE('<2Y+8M>', "Testing Period Starting Date");
                                                    END;
                                                    IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                        CountMonths := 8;
                                                        LastFoundDate := TempDate;
                                                        TempDate := CALCDATE('<2Y+9M+1D>', "Testing Period Starting Date");
                                                        IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                            TempDate := CALCDATE('<+2Y+9M>', "Testing Period Starting Date");
                                                        END;
                                                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                            CountMonths := 9;
                                                            LastFoundDate := TempDate;
                                                            TempDate := CALCDATE('<2Y+10M-1D>', "Testing Period Starting Date");
                                                            IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                TempDate := CALCDATE('<2Y+10M>', "Testing Period Starting Date");
                                                            END;
                                                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                CountMonths := 10;
                                                                LastFoundDate := TempDate;
                                                                TempDate := CALCDATE('<2Y+11M-1D>', "Testing Period Starting Date");
                                                                IF ((DATE2DMY("Testing Period Starting Date", 1) = 31) AND ((DATE2DMY(TempDate, 1) = 29) OR (DATE2DMY(TempDate, 1) = 27))) THEN BEGIN
                                                                    TempDate := CALCDATE('<2Y+11M>', "Testing Period Starting Date");
                                                                END;
                                                                IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                                                    CountMonths := 11;
                                                                    LastFoundDate := TempDate;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                        END;
                        // *** find count of days ***
                        TempDate := CALCDATE('<+1D>', LastFoundDate);
                        Found := TRUE;
                        REPEAT
                            IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                                CountDays += 1;
                                LastFoundDate := TempDate;
                                TempDate := CALCDATE('<+1D>', TempDate);
                            END ELSE
                                Found := FALSE;
                        UNTIL NOT Found;
                    END;
                    "Probation Days" := CountDays;
                    "Probation Months" := CountMonths;
                    "Probation Year" := CountYears;
                END
                ELSE BEGIN
                    "Probation Days" := 0;
                    "Probation Months" := 0;
                    "Probation Year" := 0;
                END;
                IF ("Testing Period Starting Date" = 0D) OR ("Testing Period Ending Date" = 0D) THEN BEGIN
                    "Probation Days" := 0;
                    "Probation Months" := 0;
                    "Probation Year" := 0;
                END;
                IF ("Probation Months" = 0) AND ("Probation Year" = 0) AND ("Testing Period Ending Date" <> 0D) AND ("Testing Period Starting Date" <> 0D) THEN BEGIN
                    TempDate := CALCDATE('<+1D>', "Testing Period Starting Date");
                    CountDays := 1;
                    Found := TRUE;
                    REPEAT
                        IF (TempDate <= "Testing Period Ending Date") AND (RecDate.GET(RecDate."Period Type"::Date, TempDate)) THEN BEGIN
                            CountDays += 1;
                            LastFoundDate := TempDate;
                            TempDate := CALCDATE('<+1D>', TempDate);
                        END ELSE
                            Found := FALSE;
                    UNTIL NOT Found;
                    "Probation Days" := CountDays;
                END;

            end;
        }
        field(37; "Prohibition of Competition"; Boolean)
        {
            Caption = 'Prohibition of Competition';
        }
        field(38; "POC Starting Date"; Date)
        {
            Caption = 'POC Starting Date';

            trigger OnValidate()
            begin
                IF "POC Ending Date" <> 0D THEN BEGIN
                    IF "POC Starting Date" = 0D THEN
                        ERROR(Text000);
                    IF "POC Ending Date" < "POC Starting Date" THEN
                        ERROR(Text001);
                END;
            end;
        }
        field(39; "POC Ending Date"; Date)
        {
            Caption = 'POC Ending Date';

            trigger OnValidate()
            begin
                IF "POC Ending Date" <> 0D THEN BEGIN
                    IF "POC Starting Date" = 0D THEN
                        ERROR(Text000);
                    IF "POC Ending Date" < "POC Starting Date" THEN
                        ERROR(Text001);
                END;
            end;
        }
        field(41; IS; Boolean)
        {
            Caption = 'IS';
        }
        field(42; "IS Date From"; Date)
        {
            Caption = 'IS Date From';

            trigger OnValidate()
            begin
                IF "IS Date To" <> 0D THEN BEGIN
                    IF "IS Date From" = 0D THEN
                        ERROR(Text000);
                    IF "IS Date To" < "IS Date From" THEN
                        ERROR(Text001);
                END;
            end;
        }
        field(43; "IS Date To"; Date)
        {
            Caption = 'IS Date To';

            trigger OnValidate()
            begin
                IF "IS Date To" <> 0D THEN BEGIN
                    IF "IS Date From" = 0D THEN
                        ERROR(Text000);
                    IF "IS Date To" < "IS Date From" THEN
                        ERROR(Text001);
                END;
            end;
        }
        field(44; "Control Function"; Boolean)
        {
            Caption = 'Control Function';
        }
        field(45; "Control Function From"; Date)
        {
            Caption = 'Control Function From';

            trigger OnValidate()
            begin
                IF "Control Function To" <> 0D THEN BEGIN
                    IF "Control Function From" = 0D THEN
                        ERROR(Text000);
                    IF "Control Function To" < "Control Function From" THEN
                        ERROR(Text001);
                END;
            end;
        }
        field(46; "Control Function To"; Date)
        {
            Caption = 'Control Function To';

            trigger OnValidate()
            begin
                IF "Control Function To" <> 0D THEN BEGIN
                    IF "Control Function From" = 0D THEN
                        ERROR(Text000);
                    IF "Control Function To" < "Control Function From" THEN
                        ERROR(Text001);
                END;
            end;
        }
        field(47; "Additional Benefits"; Boolean)
        {
            Caption = 'Additional Benefits';

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN BEGIN
                    "Order By" := 5;
                    /*IF "Position Description"='VD*' THEN
                    "Order By":=1;*/
                    IF STRPOS("Position Description", 'VD') <> 0 THEN
                        "Order By" := 1;
                    IF ("Additional Benefits") AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 2;
                    IF ("Temporary disposition" = TRUE) AND ("Additional Benefits" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 3;
                    IF (("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI')) AND ("Additional Benefits" = FALSE) AND ("Temporary disposition" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 4
                END;

            end;
        }
        field(48; "Manager Contract"; Boolean)
        {
            Caption = 'Manager Contract';

            trigger OnValidate()
            begin
                IF "Manager Contract" = FALSE THEN BEGIN
                    "Fixed Amount Brutto" := 0;
                    "Fixed Amount Netto" := 0;
                    "Fixed Amount Total Netto" := 0;
                    "Variable Amount Brutto" := 0;
                    "Variable Amount Netto" := 0;
                    "Manager Addition Total Netto" := 0;
                END
                ELSE BEGIN
                    IF ("Percentage of Fixed Part" <> 0) THEN BEGIN
                        "Fixed Amount Brutto" := ("Percentage of Fixed Part" / 100) * Brutto;
                        "Fixed Amount Netto" := ("Percentage of Fixed Part" / 100) * Rec.Netto;
                        "Fixed Amount Total Netto" := ("Percentage of Fixed Part" / 100) * "Total Netto";
                        "Variable Amount Brutto" := (1 - ("Percentage of Fixed Part" / 100)) * Brutto;
                        "Variable Amount Netto" := (1 - ("Percentage of Fixed Part" / 100)) * Rec.Netto;
                        "Manager Addition Total Netto" := (1 - ("Percentage of Fixed Part" / 100)) * "Total Netto";
                        "Percentage of Variable" := 100 - "Percentage of Fixed Part";
                    END
                    ELSE BEGIN

                        "Percentage of Variable" := 0;
                    END;
                END;
            end;
        }
        field(49; "Manner of Term. Code"; Code[10])
        {
            Caption = 'Manner of Termination Code';
            Editable = false;

            trigger OnValidate()
            begin
                /*IF "Manner of Term. Code"<>'' THEN BEGIN
                  {GroundsForTermination.RESET;
                 // GroundsForTermination.SETFILTER(Type,'Manner');
                 // GroundsForTermination.SETFILTER("Code Manner","Grounds for Term. Code");
                 GroundsForTermination.SETFILTER("Code Manner","Manner of Term. Code");
                  IF GroundsForTermination.FINDFIRST THEN
                    "Manner of Term. Description":=GroundsForTermination."Description Manner";
                  END
                  ELSE
                    "Manner of Term. Description":='';}
                MannersForTermination.RESET;
                MannersForTermination.SETFILTER("Code Reason","Grounds for Term. Code");
                IF MannersForTermination.FIND('-') THEN
                MannersForTermination.SETFILTER("Code Manner","Manner of Term. Code");
                "Manner of Term. Description":=MannersForTermination."Description Manner";
                END
                ELSE
                 "Manner of Term. Description":='';*/
                /*IF "Manner of Term. Code"<>'' THEN BEGIN
                  MannersForTermination.RESET;
                  MannersForTermination.SETFILTER("Code Manner","Manner of Term. Code");
                  IF MannersForTermination.FINDFIRST THEN
                    "Manner of Term. Description":=MannersForTermination."Description Manner";
                  END
                  ELSE
                    "Manner of Term. Description":='';*/


            end;
        }
        field(50; "Exit Interview"; Boolean)
        {
            Caption = 'Exit Interview';
        }
        field(51; "Employment Abroad"; Boolean)
        {
            Caption = 'Employment Abroad';

            trigger OnValidate()
            begin

                IF "Employment Abroad" = TRUE THEN BEGIN
                    StartDate := "Starting Date";
                    EndDate := "Ending Date";
                END;
            end;
        }
        field(52; "Employment Abroad City"; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Empl.Abroad Country/Region" = FILTER('')) "Post Code".City
            ELSE
            IF ("Empl.Abroad Country/Region" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Empl.Abroad Country/Region"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //ĐK   PostCode.ValidateCityBirth("Employment Abroad City", "Empl.Abroad Country/Region", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(53; "Empl.Abroad Country/Region"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region".Code;
        }
        field(54; Active; Boolean)
        {
            Caption = 'Active';
            Editable = false;

            trigger OnValidate()
            begin
                //WG01
                IF "Starting Date" <> 0D THEN BEGIN
                    // IF DATE2DMY("Starting Date",1)=1 THEN
                    BEGIN
                        //  xRec.FINDLAST;
                        IF (xRec."No." = Rec."No.") THEN BEGIN
                            xRec.RESET;
                            WageAmounts.RESET;
                            WageAmounts.SETFILTER("Employee No.", "Employee No.");
                            IF WageAmounts.FINDFIRST THEN BEGIN
                                WageAmounts.VALIDATE("Wage Amount", Brutto);
                                IF DATE2DMY("Starting Date", 1) <> 1 THEN BEGIN
                                    EmployeeContractLedger.RESET;
                                    EmployeeContractLedger.SETCURRENTKEY("Employee No.", "Starting Date");
                                    EmployeeContractLedger.SETFILTER("Employee No.", "Employee No.");
                                    EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                                    EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
                                    IF EmployeeContractLedger.FINDLAST THEN BEGIN
                                        EmployeeContractLedgerPrevious := EmployeeContractLedger;
                                        EmployeeContractLedgerPrevious.SETFILTER("Show Record", '%1', TRUE);
                                        EmployeeContractLedgerPrevious.setfilter("Employee No.", "Employee No.");
                                        EmployeeContractLedgerPrevious.SETCURRENTKEY("Employee No.", "Starting Date");
                                        EmployeeContractLedgerPrevious.NEXT(-1);
                                        WageAmounts.VALIDATE("Old Amount", EmployeeContractLedgerPrevious.Brutto);
                                        WageAmounts.VALIDATE("Application Date", Rec."Starting Date");
                                    END;
                                END;
                                WageAmounts.MODIFY;
                            END
                            ELSE BEGIN
                                WageAmounts.RESET;
                                WageAmounts.INIT;
                                WageAmounts.VALIDATE("Employee No.", "Employee No.");
                                WageAmounts.VALIDATE("Wage Amount", Brutto);
                                IF DATE2DMY("Starting Date", 1) <> 1 THEN BEGIN
                                    EmployeeContractLedger.RESET;
                                    EmployeeContractLedger.SETCURRENTKEY("Employee No.", "Starting Date");
                                    EmployeeContractLedger.SETFILTER("Employee No.", "Employee No.");
                                    EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
                                    EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                                    IF EmployeeContractLedger.FINDLAST THEN BEGIN
                                        EmployeeContractLedgerPrevious := EmployeeContractLedger;
                                        EmployeeContractLedgerPrevious.SETFILTER("Show Record", '%1', TRUE);
                                        EmployeeContractLedgerPrevious.setfilter("Employee No.", "Employee No.");
                                        EmployeeContractLedgerPrevious.SETCURRENTKEY("Employee No.", "Starting Date");
                                        EmployeeContractLedgerPrevious.NEXT(-1);
                                        WageAmounts.VALIDATE("Old Amount", EmployeeContractLedgerPrevious.Brutto);
                                        WageAmounts.VALIDATE("Application Date", EmployeeContractLedger."Starting Date");
                                    END;
                                END;
                                WageAmounts.INSERT;
                            END;
                        END
                    END;
                END;





                IF (("Starting Date" >= 20170901D)) THEN BEGIN
                    EDF.SETFILTER("No.", '%1', "Employee No.");
                    IF EDF.FIND('-') THEN BEGIN
                        EDF.VALIDATE("No.", "Employee No.");
                        EDF."Dimension Code" := 'TC';
                        CALCFIELDS("Phisical Org Dio");
                        DV.SETFILTER(Code, '%1', "Phisical Org Dio" + '-' + "Department Code");
                        IF NOT DV.FIND('-') THEN BEGIN
                            DV.INIT;
                            DV."Dimension Code" := 'TC';
                            DV.Code := "Phisical Org Dio" + '-' + "Department Code";
                            DV."Global Dimension No." := 1;
                            DV.INSERT;
                        END;
                        IF (("Department Code" <> '') AND ("Phisical Org Dio" <> '')) THEN
                            EDF."Dimension Value Code" := "Phisical Org Dio" + '-' + "Department Code"
                        ELSE
                            EDF."Dimension Value Code" := '';
                        EDF."Amount Distribution Coeff." := 1;
                        EDF.MODIFY;
                    END

                    ELSE BEGIN
                        EDF.INIT;
                        EDF.VALIDATE("No.", "Employee No.");
                        EDF."Dimension Code" := 'TC';
                        CALCFIELDS("Phisical Org Dio");
                        DV.SETFILTER(Code, '%1', "Phisical Org Dio" + '-' + "Department Code");
                        IF NOT DV.FIND('-') THEN BEGIN
                            DV.INIT;
                            DV."Dimension Code" := 'TC';
                            DV.Code := "Phisical Org Dio" + '-' + "Department Code";
                            DV."Global Dimension No." := 1;
                            DV.INSERT;
                        END;
                        IF (("Department Code" <> '') AND ("Phisical Org Dio" <> '')) THEN
                            EDF."Dimension Value Code" := "Phisical Org Dio" + '-' + "Department Code"
                        ELSE
                            EDF."Dimension Value Code" := '';
                        EDF."Amount Distribution Coeff." := 1;
                        EDF.INSERT;
                    END;
                END;
                IF "Org Unit Name" <> '' THEN
                    VALIDATE("Org Unit Name", "Org Unit Name")
                ELSE
                    VALIDATE("GF of work Description", "GF of work Description");
                ORGShema.RESET;
                ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Active);
                IF ORGShema.FINDLAST THEN BEGIN
                    HeadOfRefresh.SETFILTER("ORG Shema", '%1', ORGShema.Code);
                    HeadOfRefresh.SETFILTER("Position Code", '%1', "Position Code");
                    IF HeadOfRefresh.FINDLAST THEN
                        Status := Status::Active
                    ELSE
                        Status := Status::Terminated;
                END;

                IF Rec.Active = TRUE THEN BEGIN
                    EmployeeContractLedger2.RESET;
                    EmployeeContractLedger2.SETFILTER("Employee No.", '%1', "Employee No.");
                    EmployeeContractLedger2.SETFILTER("Grounds for Term. Description", '<>%1', '');
                    EmployeeContractLedger2.SETFILTER("Show Record", '%1', TRUE);
                    IF EmployeeContractLedger2.FINDSET THEN
                        REPEAT
                            EmployeeContractLedger2.Active := FALSE;
                            EmployeeContractLedger2.MODIFY;


                        UNTIL EmployeeContractLedger2.NEXT = 0;

                END;
            end;
        }
        field(55; "Testing Period (Duration Opt.)"; Option)
        {
            Caption = 'Testing Period (Duration Opt.)';
            OptionCaption = ' ,1 month,2 months,3 months,4 months,5 months,6 months';
            OptionMembers = " ","1 month","2 months","3 months","4 months","5 months","6 months";

            trigger OnValidate()
            begin
                //AJ
                /*IF ( ("Testing Period Starting Date"<>0D)) THEN BEGIN
                CASE  "Testing Period (Duration Opt.)" OF
                
                  "Testing Period (Duration Opt.)"::"1 month":
                  BEGIN
                  "Testing Period Ending Date":=CALCDATE('1M-1D',"Testing Period Starting Date");
                    "Ending Date":="Testing Period Ending Date";
                  END;
                   "Testing Period (Duration Opt.)"::"2 months":
                  BEGIN
                  "Testing Period Ending Date":=CALCDATE('2M-1D',"Testing Period Starting Date");
                    "Ending Date":="Testing Period Ending Date";
                  END;
                   "Testing Period (Duration Opt.)"::"3 months":
                  BEGIN
                  "Testing Period Ending Date":=CALCDATE('3M-1D',"Testing Period Starting Date");
                    "Ending Date":="Testing Period Ending Date";
                  END;
                   "Testing Period (Duration Opt.)"::"4 months":
                  BEGIN
                  "Testing Period Ending Date":=CALCDATE('4M-1D',"Testing Period Starting Date");
                    "Ending Date":="Testing Period Ending Date";
                  END;
                   "Testing Period (Duration Opt.)"::"5 months":
                  BEGIN
                  "Testing Period Ending Date":=CALCDATE('5M-1D',"Testing Period Starting Date");
                  "Ending Date":="Testing Period Ending Date";
                  END;
                   "Testing Period (Duration Opt.)"::"6 months":
                  BEGIN
                  "Testing Period Ending Date":=CALCDATE('6M-1D',"Testing Period Starting Date");
                  "Ending Date":="Testing Period Ending Date";
                  END;
                   "Testing Period (Duration Opt.)"::" ":
                  BEGIN
                  "Testing Period Ending Date":=0D;
                  END;
                END;
                END;*/

            end;
        }
        field(56; "Manner of Term. Description"; Text[200])
        {
            Caption = 'Manner of Term. Description';
            Editable = true;
            TableRelation = "Manner for Termination"."Description Manner";

            trigger OnValidate()
            begin
                IF "Manner of Term. Description" <> '' THEN BEGIN
                    MannersForTermination.RESET;
                    MannersForTermination.SETFILTER("Description Manner", "Manner of Term. Description");
                    IF MannersForTermination.FINDFIRST THEN
                        VALIDATE("Manner of Term. Code", MannersForTermination."Code Manner");
                END
                ELSE
                    "Manner of Term. Code" := '';
                "Grounds for Term. Code" := '';
                "Grounds for Term. Description" := ''

            end;
        }
        field(57; "Grounds for Term. Description"; Text[200])
        {
            Caption = 'Grounds for Term. Description';
            Editable = true;
            TableRelation = "Grounds for Termination"."Description" WHERE("Code" = FIELD("Manner of Term. Code"));
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                IF "Grounds for Term. Description" <> '' THEN BEGIN
                    GroundsForTermination.RESET;
                    GroundsForTermination.SETFILTER("Description", "Grounds for Term. Description");
                    IF GroundsForTermination.FINDFIRST THEN
                        VALIDATE("Grounds for Term. Code", GroundsForTermination."Code")
                    else
                        VALIDATE("Grounds for Term. Code", '');

                END
                ELSE begin
                    "Grounds for Term. Code" := '';

                end;
            end;

        }
        field(58; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';

            trigger OnValidate()
            begin

                IF "Operator No." <> xRec."Operator No." THEN BEGIN
                    HRSetup.GET;
                    NoSeriesMgt.TestManual(HRSetup."Operator Nos.");

                END;
            end;
        }
        field(50280; "Order"; Integer)
        {
        }
        field(50281; "Testing Period - Comment"; Text[100])
        {
            Caption = 'Testing Period - comment';
        }
        field(50282; "Additional Responsiblity"; Text[200])
        {
            Caption = 'Additional Responsiblity';
            TableRelation = "Additional Responsibility";
        }
        field(50283; "Testing period duration"; DateTime)
        {
        }
        field(50284; "Probation Days"; Integer)
        {
            Caption = 'Probation Days';
            Editable = false;
        }
        field(50285; "Probation Months"; Integer)
        {
            Caption = 'Probation Months';
            Editable = false;
        }
        field(50286; "Reason for Change"; Option)
        {
            Caption = 'Reason for Change';
            OptionCaption = ' ,Migration,New Contract,Position Change,Workplace Change,Disciplinary Measures,Contract Renewal,Organizational Changes 1,Organizational Changes 2,Organizational Changes 3,Organizational Changes 4,Workplace And Wage Change,Position Location And Wage Change,Wage Change,Workplace Description Change,Workplace Description And Wage Change,Organisational Structure Changes,Systematization Change,Change engagement type';
            OptionMembers = " ",Migration,"New Contract","Position Change","Workplace Change","Disciplinary Measures","Contract Renewal","Organizational Changes 1","Organizational Changes 2","Organizational Changes 3","Organizational Changes 4","Workplace And Wage Change","Position Location And Wage Change","Wage Change","Workplace Description Change","Workplace Description And Wage Change","Organisational Structure Changes","Systematization Change","Change engagement type";

            trigger OnValidate()
            begin
                //Brojac:=0;
                /*IF ((xRec."Reason for Change"<>0) AND (Brojac=0)) THEN BEGIN
                  IF ((xRec."Reason for Change"<>Rec."Reason for Change") )
                     THEN BEGIN
                
                           Answer :=CONFIRM('Da li želite promijeiti vrijednost polja "%1" iz "%2" u "%3"?',TRUE,
                    FIELDCAPTION("Reason for Change"),xRec."Reason for Change",Rec."Reason for Change");
                    IF Answer =FALSE THEN BEGIN
                  "Reason for Change":= xRec."Reason for Change";
                    Brojac:=1;
                      END
                      ELSE BEGIN
                 MESSAGE ('Da') ;
                    END;
                   END
                  END;*/
                /*IF ((Rec."Reason for Change"=Rec."Reason for Change"::"New Contract") AND (xRec."Reason for Change"=0))
                THEN VALIDATE(Rec."Starting Date","Starting Date");*/

            end;
        }
        field(50289; "Minimal Education Level"; Option)
        {
            CalcFormula = Lookup(Position."Minimal Education Level" WHERE(Code = FIELD("Position Code")));
            Caption = 'Education level';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,I Stepen četri razreda osnovne,II Stepen - osnovna škola,III Stepen - SSS srednja škola,IV Stepen - SSS srednja škola,V Stepen - VKV - SSS srednja škola,VI Stepen - VS viša škola,VII Stepen - VSS visoka stručna sprema,VII-1 Stepen - Specijalista,VII-2 Stepen - Magistratura,VIII Stepen - Doktorat  ';
            OptionMembers = " ","I Stepen četri razreda osnovne","II Stepen - osnovna škola","III Stepen - SSS srednja škola","IV Stepen - SSS srednja škola","V Stepen - VKV - SSS srednja škola","VI Stepen - VS viša škola","VII Stepen - VSS visoka stručna sprema","VII-1 Stepen - Specijalista","VII-2 Stepen - Magistratura","VIII Stepen - Doktorat  ";
        }
        field(50290; "Additional Position"; Boolean)
        {
            Caption = 'Additional Position';
        }
        field(50293; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
        }
        field(50294; "Residence/Network"; Option)
        {
            CalcFormula = Lookup(Department."Residence/Network" WHERE(Code = FIELD("Department Code"),
                                                                     "ORG Shema" = FIELD("Org. Structure")));
            Caption = 'Residence/Network';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;
        }
        field(50295; "Department Name"; Text[150])
        {
            Caption = 'Department Name';
            TableRelation = IF ("Sector Description" = FILTER(<> ''),
                                "Department Cat. Description" = FILTER('')) Department.Description WHERE("Sector  Description" = FIELD("Sector Description"),
                                                                                                      "ORG Shema" = FIELD("Org. Structure"),
                                                                                                      "Department Type" = CONST(Sector))
            ELSE
            IF ("Department Cat. Description" = FILTER(<> ''),
                                                                                                               "Group Description" = FILTER('')) Department.Description WHERE("Department Categ.  Description" = FIELD("Department Cat. Description"),
                                                                                                                                                                           "ORG Shema" = FIELD("Org. Structure"),
                                                                                                                                                                           "Department Type" = CONST(Department))
            ELSE
            IF ("Group Description" = FILTER(<> ''),
                                                                                                                                                                                    "Team Description" = FILTER('')) Department.Description WHERE("Group Description" = FIELD("Group Description"),
                                                                                                                                                                                                                                              "ORG Shema" = FIELD("Org. Structure"),
                                                                                                                                                                                                                                               "Department Type" = CONST(Group))
            ELSE
            IF ("Team Description" = FILTER(<> '')) Department.Description WHERE("Team Description" = FIELD("Team Description"),
                                                                                                                                                                                                                                                                                                                     "ORG Shema" = FIELD("Org. Structure"),
                                                                                                                                                                                                                                                                                                                     "Department Type" = CONST(Team));
        }
        field(50296; "Department Address"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi".Address WHERE(Code = FIELD("Org Dio"),
                                                               GF = FIELD("GF rada code")));
            Caption = 'Department Address';
            Editable = false;

        }
        field(50297; "Department City"; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi".City WHERE(Code = FIELD("Org Dio"),
                                                            GF = FIELD("GF rada code")));
            Caption = 'Department City';
            Editable = false;

        }
        field(50298; Municipality; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi"."Municipality Code of agency" WHERE(Code = FIELD("Org Dio"),
                                                                                     GF = FIELD("GF rada code")));
            Caption = 'Municipality';
            Editable = false;

        }
        field(50299; Sector; Code[30])
        {
            Caption = 'Sector';
            Editable = true;
            FieldClass = Normal;
            TableRelation = Sector.Code WHERE("Org Shema" = FIELD("Org. Structure"));
        }
        field(50300; "Sector Description"; Text[200])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = Sector.Description WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                IF ((Team = '') AND (Group = '') AND ("Department Category" = '')) THEN BEGIN
                    Department.RESET;
                    Department.SETFILTER("Sector  Description", '%1', "Sector Description");
                    Department.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    IF Department.FIND('-') THEN BEGIN

                        "Sector Description" := Department."Sector  Description";
                        IF ("Sector Description" <> '') AND ("Department Cat. Description" = '') THEN BEGIN
                            "Department Name" := Department."Sector  Description";
                            "Org Belongs" := Department."Sector  Description";
                            Izmjena := TRUE;

                        END;
                        IF "Sector Description" <> '' THEN BEGIN

                            VALIDATE("Department Code", Department.Sector);

                            VALIDATE(Sector, Department.Sector);
                            //   VALIDATE(Description,"Sector Description");
                        END;
                    END;
                END;


                IF "Sector Description" = '' THEN BEGIN
                    "Sector Code" := '';
                    Sector := '';
                    "Department Cat. Description" := '';
                    "Department Category" := '';
                    Group := '';
                    "Group Description" := '';
                    Team := '';
                    "Team Description" := '';
                    "Department Code" := '';
                    "Department Name" := '';
                    "Position Description" := '';
                    "Position Code" := '';
                    "Org Belongs" := '';
                    "Management Level" := 0;
                    "Key Function" := FALSE;
                    "Control Function" := FALSE;
                END;

            end;
        }
        field(50301; "Department Category"; Code[30])
        {
            Caption = 'Odjel';
            Editable = true;
            TableRelation = "Department Category".Code WHERE("Org Shema" = FIELD("Org. Structure"));
        }
        field(50302; "Department Cat. Description"; Text[250])
        {
            Caption = 'Department Cat. Description';
            FieldClass = Normal;
            TableRelation = "Department Category".Description WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                IF ((Team = '') AND (Group = '')) THEN BEGIN
                    Department.RESET;
                    Department.SETFILTER("Department Categ.  Description", '%1', "Department Cat. Description");
                    Department.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    IF Department.FIND('-') THEN BEGIN

                        "Department Cat. Description" := Department."Department Categ.  Description";
                        IF ("Group Description" = '') AND ("Department Cat. Description" <> '') THEN BEGIN
                            "Department Name" := Department."Department Categ.  Description";
                            "Org Belongs" := Department."Department Categ.  Description";
                            Izmjena := TRUE;
                        END;
                        IF "Department Cat. Description" <> '' THEN BEGIN
                            Department.RESET;
                            Department.SETFILTER("Department Categ.  Description", '%1', "Department Cat. Description");
                            Department.SETFILTER("Department Type", '%1', 4);
                            Department.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            IF Department.FINDFIRST THEN
                                "Department Category" := Department."Department Category";
                            VALIDATE("Department Code", Department."Department Category");
                            VALIDATE("Department Category", Department."Department Category");

                            VALIDATE(Sector, Department.Sector);
                            VALIDATE("Sector Description", Department."Sector  Description");
                            //   VALIDATE(Description,"Department Cat. Description");
                        END;
                    END;
                END;

                IF "Department Cat. Description" = '' THEN BEGIN
                    "Sector Code" := '';
                    Sector := '';
                    "Department Cat. Description" := '';
                    "Department Category" := '';
                    Group := '';
                    "Group Description" := '';
                    Team := '';
                    "Team Description" := '';
                    "Department Code" := '';
                    "Department Name" := '';
                    "Position Description" := '';
                    "Position Code" := '';
                    "Org Belongs" := '';
                    "Management Level" := 0;
                    "Key Function" := FALSE;
                    "Control Function" := FALSE;
                    "Sector Description" := '';

                END;
            end;
        }
        field(50303; Group; Code[30])
        {
            Caption = 'Group';
            Editable = true;
            FieldClass = Normal;
            TableRelation = Group.Code WHERE("Org Shema" = FIELD("Org. Structure"));
        }
        field(50304; "Group Description"; Text[200])
        {
            Caption = 'Group Description';
            Editable = true;
            TableRelation = "Group".Description WHERE("Org Shema" = FIELD("Org. Structure"));
            trigger OnValidate()
            begin
                IF Team = '' THEN BEGIN
                    Department.RESET;
                    Department.SETFILTER("Group Description", '%1', "Group Description");
                    Department.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    IF Department.FIND('-') THEN BEGIN

                        "Group Description" := Department."Group Description";
                        IF ("Group Description" <> '') AND ("Team Description" = '') THEN BEGIN
                            "Department Name" := Department."Group Description";
                            "Org Belongs" := Department."Group Description";
                            Izmjena := TRUE;
                        END;

                        IF "Group Description" <> '' THEN BEGIN

                            VALIDATE("Department Code", Department."Group Code");
                            VALIDATE(Group, Department."Group Code");
                            VALIDATE("Department Category", Department."Department Category");
                            VALIDATE("Department Cat. Description", Department."Department Categ.  Description");
                            VALIDATE(Sector, Department.Sector);
                            VALIDATE("Sector Description", Department."Sector  Description");
                            //  VALIDATE(Description,"Group Description");
                        END;
                    END;
                END;

                IF "Group Description" = '' THEN BEGIN
                    "Sector Code" := '';
                    Sector := '';
                    "Sector Description" := '';
                    "Department Cat. Description" := '';
                    "Department Category" := '';
                    Group := '';
                    "Group Description" := '';
                    Team := '';
                    "Team Description" := '';
                    "Department Code" := '';
                    "Department Name" := '';
                    "Position Description" := '';
                    "Position Code" := '';
                    "Org Belongs" := '';
                    "Management Level" := 0;
                    "Key Function" := FALSE;
                    "Control Function" := FALSE;
                END;

            end;
        }
        field(50305; "Organizational Affiliation"; Code[10])
        {
            Caption = 'Organizational Affiliation';
        }
        field(50307; "Manager 1"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."Manager 1 Code" WHERE(Code = FIELD("Position Code"),
                                                                  "Org. Structure" = FIELD("Org. Structure"),
                                                                  "Manager Is Employee" = FILTER(FALSE),
                                                                  Description = FIELD("Position Description"),
                                                                  "Employee No." = FIELD("Employee No."),
                                                                  "Department Code" = FIELD("Department Code")));
            Caption = 'Manager 1';


            trigger OnValidate()
            begin
                CALCFIELDS("Manager 1 First Name", "Manager 1 Last Name", "Manager 1 Position Code");
            end;
        }
        field(50308; "Manager 1 First Name"; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD("Manager 1")));
            Caption = 'Manager 1 First Name';
            Editable = false;

        }
        field(50309; "Manager 1 Last Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Last Name" WHERE("No." = FIELD("Manager 1")));
            Caption = 'Manager 1 Last Name';
            Editable = false;

        }
        field(50310; "Manager 1 Position Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Max("Employee Contract Ledger"."Position Code" WHERE("Employee No." = FIELD("Manager 1"),
                                                                                "Org. Structure" = FIELD("Org. Structure")));
            Caption = 'Manager 1 Position Code';
            Editable = false;

        }
        field(50311; "Manager 2"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."Manager 2 Code" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                  Code = FIELD("Position Code"),
                                                                  "Employee No." = FIELD("Employee No."),
                                                                  "Department Code" = FIELD("Department Code"),
                                                                  Description = FIELD("Position Description")));
            Caption = 'Manager 2';

            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                CALCFIELDS("Manager 2 First Name", "Manager 2 Last Name", "Manager 2 Position Code");
            end;
        }
        field(50312; "Manager 2 First Name"; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD("Manager 2")));
            Caption = 'Manager 2 First Name';
            Editable = false;

        }
        field(50313; "Manager 2 Last Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Last Name" WHERE("No." = FIELD("Manager 2")));
            Caption = 'Manager 2 Last Name';
            Editable = false;

        }
        field(50314; "Manager 2 Position Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position.Code WHERE("Employee No." = FIELD("Manager 2"),
                                                      "Org. Structure" = FIELD("Org. Structure")));
            Caption = 'Manager 2 Position Code';
            Editable = false;

        }
        field(50315; "Org. Structure"; Code[10])
        {
            Caption = 'Org. Structure';
            TableRelation = "ORG Shema";
        }
        field(50316; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = Department."Code" WHERE("ORG Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin

                CALCFIELDS("Residence/Network");

                Department.RESET;
                Department.SETFILTER("ORG Shema", "Org. Structure");

                Department.SETFILTER("Code", "Department Code");
                IF Department.FINDFIRST THEN BEGIN
                    Department.CALCFIELDS(Municipality);

                    parent2 := Department."Timesheets administrator";
                    parent3 := Department."Timesheets administrator 2";
                END;
            end;
        }
        field(50317; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
            Editable = true;
            TableRelation = Position.Code WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                 "Employee No." = FIELD("Employee No."));

            trigger OnValidate()
            begin

                pos.RESET;
                pos.SETFILTER("Code", '%1', "Position Code");
                IF pos.FINDFIRST THEN BEGIN
                    "Management Level" := pos."Management Level";
                    "Key Function" := pos."Key Function";
                    "Control Function" := pos."Control Function";
                END;



                BEGIN
                    position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                    position.SETFILTER(Code, '%1', "Position Code");
                    position.SETFILTER("Employee No.", '%1', "Employee No.");
                    IF NOT position.FINDFIRST THEN BEGIN
                        position.VALIDATE(Code, "Position Code");
                        NewPosition.SETFILTER(Code, '%1', "Position Code");
                        IF NewPosition.FINDFIRST THEN
                            position.Description := Rec."Position Description";
                        position."Key Function" := NewPosition."Key Function";
                        position."Control Function" := NewPosition."Control Function";
                        position."Org. Structure" := "Org. Structure";
                        // position.VALIDATE("Department Code","Department Code");
                        position."Department Code" := "Department Code";
                        position."Management Level" := "Management Level";
                        position."Employee No." := "Employee No.";
                        Employee.RESET;
                        Employee.SETFILTER("No.", "Employee No.");
                        IF Employee.FINDFIRST THEN
                            position."Employee Full Name" := Employee."Last Name" + ' ' + Employee."First Name";

                        position.INSERT;
                        "Position ID" := position."Position ID";
                        position.VALIDATE("Team Description", "Team Description");
                        position.VALIDATE("Group Description", "Group Description");
                        position.VALIDATE("Department Categ.  Description", "Department Cat. Description");
                        position.VALIDATE("Sector  Description", "Sector Description");
                        IF (("Team Description" <> '')) THEN BEGIN

                            posDis.SETFILTER("Department Code", '%1', Team);
                            posDis.SETFILTER("Management Level", '%1', "Management Level");
                            posDis.SETFILTER("Team Description", '%1', Team);
                            IF posDis.FIND('-') THEN BEGIN
                                position.VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                                position.VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                            END
                            ELSE BEGIN
                                position.VALIDATE("Disc. Department Code", Team);
                                position.VALIDATE("Disc. Department Name", "Team Description");
                            END;
                        END;

                        posDis.RESET;
                        IF (("Team Description" = '') AND ("Group Description" <> '')) THEN BEGIN

                            posDis.SETFILTER("Department Code", '%1', Group);
                            posDis.SETFILTER("Management Level", '%1', "Management Level");
                            posDis.SETFILTER("Group Description", '%1', Group);
                            IF posDis.FIND('-') THEN BEGIN
                                position.VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                                position.VALIDATE("Disc. Department Name", posDis."Disc. Department Name");

                            END
                            ELSE BEGIN
                                position.VALIDATE("Disc. Department Code", Group);
                                position.VALIDATE("Disc. Department Name", "Group Description");
                            END;
                        END;

                        posDis.RESET;
                        IF (("Team Description" = '') AND ("Group Description" = '') AND ("Department Cat. Description" <> '')) THEN BEGIN
                            posDis.SETFILTER("Department Code", '%1', "Department Category");
                            posDis.SETFILTER("Management Level", '%1', "Management Level");
                            posDis.SETFILTER("Department Categ.  Description", '%1', "Department Cat. Description");
                            IF posDis.FIND('-') THEN BEGIN
                                position.VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                                position.VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                            END
                            ELSE BEGIN
                                position.VALIDATE("Disc. Department Code", "Department Category");
                                position.VALIDATE("Disc. Department Code", "Department Code");
                            END;
                        END;


                        IF (("Team Description" = '') AND ("Group Description" = '') AND ("Department Cat. Description" = '')) THEN BEGIN
                            posDis.RESET;
                            posDis.SETFILTER("Department Code", '%1', Sector);
                            posDis.SETFILTER("Management Level", '%1', "Management Level");
                            posDis.SETFILTER("Sector  Description", '%1', "Sector Description");
                            IF posDis.FIND('-') THEN BEGIN
                                position.VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                                position.VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                            END
                            ELSE BEGIN
                                position.VALIDATE("Disc. Department Code", Sector);
                                position.VALIDATE("Disc. Department Code", "Department Code");
                            END;
                        END;
                        position.MODIFY;
                    END;



                END;
            end;
        }
        field(50318; "Position ID"; Code[20])
        {
            Caption = 'Position ID';

            trigger OnValidate()
            begin
                /*
                IF ((COMPANYNAME='SB') AND ("Starting Date">=010917D)) THEN BEGIN
                WPConnSetup.FINDFIRST();
                
                
                               CREATE(conn, TRUE, TRUE);
                
                               conn.Open('PROVIDER=SQLOLEDB;SERVER=HR\NAVDEMO;DATABASE=c0_intranet2;UID=intranet;PWD=DynamicsNAV16!');
                               {conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                                         +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));}
                
                               CREATE(comm,TRUE, TRUE);
                
                               lvarActiveConnection := conn;
                               comm.ActiveConnection := lvarActiveConnection;
                
                               comm.CommandText := 'dbo.PositionCode_Update';
                               comm.CommandType := 4;
                               comm.CommandTimeout := 0;
                
                               param:=comm.CreateParameter('@EmployeeNo', 200, 1, 30, "Employee No.");
                               comm.Parameters.Append(param);
                               CALCFIELDS("Position Description","Manager 1");
                               SegmentationP.RESET;
                               SegmentationP.SETFILTER("Position No.",'%1',"Position Code");
                               SegmentationP.SETFILTER("Segmentation Name",'%1',"Position Description");
                               SegmentationP.SETFILTER(Coefficient,'<>%1',0);
                               SegmentationP.SETFILTER("Ending Date",'%1',0D);
                              IF SegmentationP.FIND('+') THEN
                              param:=comm.CreateParameter('@managment_level', 200, 1, 30, SegmentationP."Management Level")
                              ELSE
                                 param:=comm.CreateParameter('@managment_level', 200, 1, 30, '0');
                               comm.Parameters.Append(param);
                
                                 param:=comm.CreateParameter('@position_code', 200, 1, 30, "Position Code");
                               comm.Parameters.Append(param);
                
                                  param:=comm.CreateParameter('@position', 200, 1, 250  , "Position Description");
                               comm.Parameters.Append(param);
                
                               param:=comm.CreateParameter('@parent', 200, 1, 30, "Manager 1");
                               comm.Parameters.Append(param);
                
                              param:=comm.CreateParameter('@stream_parent', 200, 1, 30, '');
                               comm.Parameters.Append(param);
                                comm.Execute;
                                conn.Close;
                                CLEAR(conn);
                                CLEAR(comm);
                 END;
                
                
                IF ("Starting Date">=010917D) THEN
                BEGIN
                position.SETFILTER("Org. Structure",'%1', "Org. Structure");
                position.SETFILTER(Code,'%1',"Position Code");
                position.SETFILTER("Position ID",'%1',"Position ID");
                position.SETFILTER("Employee No.",'%1','');
                IF position.FINDFIRST THEN
                  BEGIN
                    position."Employee No.":="Employee No.";
                         Employee.RESET;
                    Employee.SETFILTER("No.","Employee No.");
                    IF Employee.FINDFIRST THEN
                    position."Employee Full Name":= Employee."Last Name"+' '+Employee."First Name";
                      position.MODIFY;
                  END
                  ELSE BEGIN
                  position.RESET;
                  position.SETFILTER("Org. Structure",'%1', "Org. Structure");
                position.SETFILTER(Code,'%1',"Position Code");
                position.SETFILTER("Position ID",'%1',"Position ID");
                IF position.FIND('-') THEN BEGIN
                  IF position."Employee No."<>"Employee No." THEN
                  ERROR('Pozicija je već zauzeta ili nije kreirana!')
                  ELSE
                MESSAGE ('Pozicija je ažurirana!');
                END;
                  END;
                */

            end;
        }
        field(50319; "Position Description"; Text[250])
        {
            Caption = 'Position Description';
            Editable = true;
            TableRelation = "Position Menu".Description WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                               "Department Code" = FIELD("Department Code"));

            trigger OnValidate()
            begin

                IF "Employee No." <> '' THEN BEGIN
                    "Order By" := 5;
                    /* IF "Position Description":='VD*' THEN
                     "Order By":=1;
                     IF STRPOS("Position Description",'VD')<>0 THEN
                     "Order By":=1;
                     IF ("Additional Benefits") AND (STRPOS("Position Description",'VD')=0)  THEN
                     "Order By":=2;
                     IF ("Temporary disposition"=TRUE) AND ("Additional Benefits"=FALSE) AND (STRPOS("Position Description",'VD')=0) THEN
                     "Order By":=3;
                     IF (("Engagement Type"='ODREĐENO') OR ("Engagement Type"='ODREĐENO PROBNI')) AND ("Additional Benefits"=FALSE) AND ("Temporary disposition"=FALSE) AND (STRPOS("Position Description",'VD')=0)THEN
                     "Order By":=4*/
                END;




                //nova validacija
                IF (xRec."No." = Rec."No.") THEN BEGIN
                    PosD.SETFILTER("Employee No.", '%1', "Employee No.");
                    PosD.SETFILTER(Description, '%1', xRec."Position Description");
                    PosD.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                    PosD.SETFILTER(Code, '%1', xRec."Position Code");
                    IF PosD.FIND('-') THEN BEGIN
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", '%1', "Employee No.");
                        EmployeeContractLedger.SETFILTER("No.", '<>%1', xRec."No.");
                        EmployeeContractLedger.SETFILTER("Position Description", '%1', xRec."Position Description");
                        EmployeeContractLedger.SETFILTER("Org. Structure", '%1', "Org. Structure");
                        IF NOT EmployeeContractLedger.FIND('-') THEN BEGIN
                            IF PosD.GET(xRec."Position Code", xRec."Position ID", xRec."Org. Structure", xRec."Position Description") THEN
                                PosD.DELETE;
                        END;
                    END;
                END;
                PositionTempInsert.RESET;
                PositionTempInsert.SETFILTER("Org. Structure", '%1', "Org. Structure");
                PositionTempInsert.SETFILTER(Description, '%1', "Position Description");
                PositionTempInsert.SETFILTER(Code, '%1', "Position Code");
                PositionTempInsert.SETFILTER("Employee No.", '%1', "Employee No.");
                PositionTempInsert.SETFILTER("Department Code", '%1', "Department Code");
                IF "Position Description" <> '' THEN BEGIN
                    IF NOT PositionTempInsert.FINDFIRST THEN BEGIN

                        //Ukoliko sve identično postoji
                        PositionFind.RESET;
                        PositionFind.SETFILTER(Description, '%1', Rec."Position Description");
                        PositionFind.SETFILTER("Sector  Description", '%1', "Sector Description");
                        PositionFind.SETFILTER("Department Categ.  Description", '%1', "Department Cat. Description");
                        PositionFind.SETFILTER("Group Description", '%1', "Group Description");
                        PositionFind.SETFILTER("Team Description", '%1', "Team Description");
                        // PositionFind.SETFILTER(Code,'%1',Rec."Position Code");
                        PositionFind.SETFILTER("Org. Structure", '%1', "Org. Structure");
                        IF PositionFind.FIND('-') THEN BEGIN
                            "Position Code" := PositionFind.Code;
                            PositionFind.SETCURRENTKEY(Order);
                            PositionFind.ASCENDING;
                            IF PositionFind.FINDLAST THEN BEGIN
                                IF EVALUATE(ID, PositionFind."Position ID") THEN
                                    "Position ID" := FORMAT(ID + 1);
                                IF PositionFind."Employee No." = '' THEN BEGIN
                                    PositionTempInsert."Position ID" := FORMAT(1);
                                    "Position ID" := FORMAT(1);
                                    PositionTempInsert.Order := 1;
                                END
                                ELSE BEGIN
                                    PositionTempInsert."Position ID" := FORMAT(ID + 1);
                                    PositionTempInsert.Order := ID + 1;
                                END;
                            END
                            ELSE BEGIN
                                "Position ID" := FORMAT(1);
                                PositionTempInsert."Position ID" := FORMAT(1);
                                PositionTempInsert.Order := 1;

                            END;


                        END
                        ELSE BEGIN
                            PosMenuFind.RESET;
                            PosMenuFind.SETFILTER(Description, '%1', "Position Description");
                            PosMenuFind.SETFILTER("Org. Structure", '%1', "Org. Structure");
                            PosMenuFind.SETFILTER("Department Code", '%1', "Department Code");
                            IF PosMenuFind.FINDFIRST THEN BEGIN
                                "Position Code" := PosMenuFind.Code;
                                "Management Level" := PosMenuFind."Management Level";
                            END;


                            PositionFind.RESET;
                            PositionFind.SETFILTER(Code, '%1', "Position Code");
                            PositionFind.SETFILTER(Description, '%1', "Position Description");
                            PositionFind.SETFILTER("Org. Structure", '%1', "Org. Structure");
                            PositionFind.SETFILTER("Department Code", '%1', "Department Code");
                            IF PositionFind.FINDLAST THEN BEGIN
                                PositionFind.SETCURRENTKEY(Order);
                                PositionFind.ASCENDING;
                                IF PositionFind.FINDLAST THEN BEGIN
                                    IF EVALUATE(ID, PositionFind."Position ID") THEN
                                        "Position ID" := FORMAT(ID + 1);
                                    PositionTempInsert."Position ID" := FORMAT(ID + 1);
                                    PositionTempInsert.Order := ID + 1;
                                    IF PositionFind."Employee No." = '' THEN BEGIN
                                        PositionTempInsert."Position ID" := FORMAT(1);
                                        "Position ID" := FORMAT(1);
                                        PositionTempInsert.Order := 1;
                                    END;
                                END;
                            END
                            ELSE BEGIN
                                "Position ID" := FORMAT(1);
                                PositionTempInsert."Position ID" := FORMAT(1);
                                PositionTempInsert.Order := 1;
                            END;
                        END;

                        PositonMenuTemp.RESET;
                        PositonMenuTemp.SETFILTER(Description, '%1', Rec."Position Description");
                        PositonMenuTemp.SETFILTER("Department Code", '%1', "Department Code");
                        PositonMenuTemp.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                        IF PositonMenuTemp.FINDFIRST THEN BEGIN
                            PositionTempInsert.Code := PositonMenuTemp.Code;
                            PositionTempInsert."Key Function" := PositonMenuTemp."Key Function";
                            PositionTempInsert."Control Function" := PositonMenuTemp."Control Function";
                            PositionTempInsert."Management Level" := PositonMenuTemp."Management Level";
                            PositionTempInsert."BJF/GJF" := PositonMenuTemp."BJF/GJF";
                            PositionTempInsert."Department Code" := PositonMenuTemp."Department Code";
                            PositionTempInsert."Official Translation" := PositonMenuTemp."Official Translation";

                            PositionTempInsert.Description := PositonMenuTemp.Description;
                            PositonMenuTemp.CALCFIELDS("Number of dimension value");
                            IF PositonMenuTemp."Number of dimension value" = 1 THEN BEGIN
                                DimensionTemp.RESET;
                                DimensionTemp.SETFILTER("Position Description", '%1', "Position Description");
                                DimensionTemp.SETFILTER("Sector  Description", '%1', "Sector Description");
                                DimensionTemp.SETFILTER("Department Categ.  Description", '%1', "Department Cat. Description");
                                DimensionTemp.SETFILTER("Group Description", '%1', "Group Description");
                                DimensionTemp.SETFILTER("Team Description", '%1', "Team Description");
                                DimensionTemp.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                                IF DimensionTemp.FINDFIRST THEN BEGIN
                                    PositionTempInsert.Sector := DimensionTemp.Sector;
                                    PositionTempInsert."Sector  Description" := DimensionTemp."Sector  Description";
                                    PositionTempInsert."Department Category" := DimensionTemp."Department Category";
                                    PositionTempInsert."Department Categ.  Description" := DimensionTemp."Department Categ.  Description";
                                    PositionTempInsert."Group Code" := DimensionTemp."Group Code";
                                    PositionTempInsert."Group Description" := DimensionTemp."Group Description";
                                    PositionTempInsert."Team Code" := DimensionTemp."Team Code";
                                    PositionTempInsert."Team Description" := DimensionTemp."Team Description";
                                    PositionTempInsert."Org. Structure" := DimensionTemp."ORG Shema";
                                    IF (PositionTempInsert.Sector <> '') AND (PositionTempInsert."Department Category" = '') THEN BEGIN
                                        PositionTempInsert."Department Name" := PositionTempInsert."Sector  Description";
                                        PositionTempInsert."Department Code" := PositionTempInsert.Sector;
                                    END;
                                    IF (PositionTempInsert."Department Category" <> '') AND (PositionTempInsert."Group Code" = '') THEN BEGIN
                                        PositionTempInsert."Department Code" := PositionTempInsert."Department Category";
                                        PositionTempInsert."Department Name" := PositionTempInsert."Department Categ.  Description";
                                    END;
                                    IF (PositionTempInsert."Group Code" <> '') AND (PositionTempInsert."Team Code" = '') THEN BEGIN
                                        PositionTempInsert."Department Name" := PositionTempInsert."Group Description";
                                        PositionTempInsert."Department Code" := PositionTempInsert."Group Code";
                                    END;
                                    IF PositionTempInsert."Team Code" <> '' THEN BEGIN
                                        PositionTempInsert."Department Name" := PositionTempInsert."Team Description";
                                        PositionTempInsert."Department Code" := PositionTempInsert."Team Code";
                                    END;
                                END
                                ELSE BEGIN
                                    PositionTempInsert.Sector := '';
                                    PositionTempInsert."Sector  Description" := '';
                                    PositionTempInsert."Department Category" := '';
                                    PositionTempInsert."Department Categ.  Description" := '';
                                    PositionTempInsert."Group Code" := '';
                                    PositionTempInsert."Group Description" := '';
                                    PositionTempInsert."Team Code" := '';
                                    PositionTempInsert."Team Description" := '';
                                    PositionTempInsert."Department Name" := '';
                                END;
                            END
                            ELSE BEGIN
                                PositionTempInsert.Sector := Rec.Sector;
                                PositionTempInsert."Sector  Description" := Rec."Sector Description";
                                PositionTempInsert."Department Category" := Rec."Department Category";
                                PositionTempInsert."Department Categ.  Description" := Rec."Department Cat. Description";
                                PositionTempInsert."Group Code" := Rec.Group;
                                PositionTempInsert."Group Description" := Rec."Group Description";
                                PositionTempInsert."Team Code" := Rec.Team;
                                PositionTempInsert."Team Description" := Rec."Team Description";
                                PositionTempInsert."Org. Structure" := Rec."Org. Structure";
                                IF (PositionTempInsert.Sector <> '') AND (PositionTempInsert."Department Category" = '') THEN
                                    PositionTempInsert."Department Name" := Rec."Sector Description";
                                IF (PositionTempInsert."Department Category" <> '') AND (PositionTempInsert."Group Code" = '') THEN
                                    PositionTempInsert."Department Name" := Rec."Department Cat. Description";
                                IF (PositionTempInsert."Group Code" <> '') AND (PositionTempInsert."Team Code" = '') THEN
                                    PositionTempInsert."Department Name" := Rec."Group Description";
                                IF PositionTempInsert."Team Code" <> '' THEN
                                    PositionTempInsert."Department Name" := Rec."Team Description";

                            END;


                            Employee.RESET;
                            Employee.SETFILTER("No.", "Employee No.");
                            IF Employee.FINDFIRST THEN
                                PositionTempInsert."Employee Full Name" := Employee."Last Name" + ' ' + Employee."First Name";
                            PositionTempInsert."Employee No." := "Employee No.";
                            ForSis.RESET;
                            ForSis.SETFILTER(Code, '%1', Sector);
                            ForSis.SETFILTER(Description, '%1', "Sector Description");
                            ForSis.SETFILTER("Org Shema", '%1', "Org. Structure");
                            IF ForSis.FINDFIRST THEN
                                PositionTempInsert."Sector Identity" := ForSis.Identity;
                            ForSis1.RESET;
                            ForSis1.SETFILTER(Code, '%1', "Department Category");
                            ForSis1.SETFILTER(Description, '%1', "Department Cat. Description");
                            ForSis1.SETFILTER("Org Shema", '%1', "Org. Structure");
                            IF ForSis1.FINDFIRST THEN
                                PositionTempInsert."Department Category Identity" := ForSis1.Identity;
                            PosMenIdentity.RESET;
                            PosMenIdentity.SETFILTER(Description, '%1', "Position Description");
                            PosMenIdentity.SETFILTER(Code, '%1', "Position Code");
                            PosMenIdentity.SETFILTER("Department Code", '%1', "Department Code");
                            PosMenIdentity.SETFILTER("Org. Structure", '%1', "Org. Structure");
                            IF PosMenIdentity.FINDFIRST THEN
                                PositionTempInsert."Position Menu Identity" := PosMenIdentity."Position Menu Identity";


                            PositionTempInsert."Org. Structure" := "Org. Structure";
                            IF (PositionTempInsert."Management Level" <> 7) AND (PositionTempInsert."Management Level" <> 0) THEN BEGIN
                                IF "Management Level" = 5 THEN BEGIN
                                    DepartmentCode.RESET;
                                    IF Team <> '' THEN BEGIN
                                        DepartmentCode.SETFILTER(Code, '%1', Group);
                                        DepartmentCode.SETFILTER("ORG Shema", '%1', "Org. Structure");
                                        IF DepartmentCode.FINDSET THEN BEGIN
                                            BrojZapisa := DepartmentCode.COUNT;
                                        END;
                                        IF BrojZapisa > 1 THEN BEGIN
                                            PositionTempInsert.VALIDATE("Disc. Department Name", "Group Description");
                                        END
                                        ELSE BEGIN
                                            PositionTempInsert.VALIDATE("Disc. Department Code", Group);
                                            PositionTempInsert."Disc. Department Name" := '';
                                        END;
                                    END;
                                    IF (Group <> '') AND (Team = '') THEN BEGIN
                                        DepartmentCode.SETFILTER(Code, '%1', Group);
                                        DepartmentCode.SETFILTER("ORG Shema", '%1', "Org. Structure");
                                        IF DepartmentCode.FINDSET THEN BEGIN
                                            BrojZapisa := DepartmentCode.COUNT;
                                        END;
                                        /*IF PositionTempInsert."Manager 1"="Employee No." THEN BEGIN
                                        PositionTempInsert."The Same Level":=FALSE;*/
                                        IF BrojZapisa > 1 THEN BEGIN
                                            PositionTempInsert.VALIDATE("Disc. Department Name", "Group Description");
                                        END
                                        ELSE BEGIN
                                            PositionTempInsert.VALIDATE("Disc. Department Code", Group);
                                            PositionTempInsert."Disc. Department Name" := '';
                                        END;
                                    END;
                                END;


                                IF "Management Level" = 4 THEN BEGIN
                                    DepartmentCode.RESET;
                                    DepartmentCode.SETFILTER(Code, '%1', "Department Category");
                                    DepartmentCode.SETFILTER("ORG Shema", '%1', "Org. Structure");
                                    IF DepartmentCode.FINDSET THEN BEGIN
                                        BrojZapisa := DepartmentCode.COUNT;
                                    END;
                                    IF BrojZapisa > 1 THEN BEGIN
                                        PositionTempInsert.VALIDATE("Disc. Department Name", "Department Cat. Description");
                                    END
                                    ELSE BEGIN
                                        PositionTempInsert.VALIDATE("Disc. Department Code", "Department Category");
                                        PositionTempInsert."Disc. Department Name" := '';
                                    END;
                                END;

                                IF "Management Level" = 3 THEN BEGIN
                                    //IF (Rec."Department Cat. Description"<>'') AND (Rec."Group Description"='')THEN BEGIN
                                    DepartmentCode.RESET;
                                    DepartmentCode.SETFILTER(Code, '%1', Sector);
                                    DepartmentCode.SETFILTER("ORG Shema", '%1', "Org. Structure");
                                    IF DepartmentCode.FINDSET THEN BEGIN
                                        BrojZapisa := DepartmentCode.COUNT;
                                    END;
                                    IF BrojZapisa > 1 THEN BEGIN
                                        PositionTempInsert.VALIDATE("Disc. Department Name", "Sector Description");
                                    END
                                    ELSE BEGIN
                                        PositionTempInsert.VALIDATE("Disc. Department Code", Sector);
                                        PositionTempInsert."Disc. Department Name" := '';
                                    END;
                                END;
                                IF "Management Level" = "Management Level"::B1 THEN BEGIN
                                    Uprava := COPYSTR(Rec.Sector, 1, 2);
                                    SectorT.RESET;
                                    SectorT.SETFILTER(Code, '%1', Uprava);
                                    SectorT.SETFILTER("Org Shema", '%1', "Org. Structure");
                                    IF SectorT.FINDFIRST THEN BEGIN
                                        PositionTempInsert.VALIDATE("Disc. Department Code", Uprava);
                                    END
                                    ELSE BEGIN
                                        PositionCEO.RESET;
                                        PositionCEO.SETFILTER("Management Level", '%1', PositionCEO."Management Level"::CEO);
                                        PositionCEO.SETFILTER("Org. Structure", '%1', "Org. Structure");
                                        IF PositionCEO.FINDFIRST THEN
                                            PositionTempInsert.VALIDATE("Disc. Department Code", PositionCEO."Department Code");
                                    END;

                                END;
                                IF "Management Level" = "Management Level"::Exe THEN BEGIN
                                    PositionTempInsert.VALIDATE("Disc. Department Code", Rec."Department Code");
                                END;
                                /*IF (Rec."Department Cat. Description"='') AND ("Sector Description"<>'')THEN
                                PositionTempInsert.VALIDATE("Disc. Department Code",Rec.Sector);*/


                            END

                            ELSE BEGIN


                                IF Rec."Team Description" <> '' THEN BEGIN
                                    DepartmentCode.RESET;
                                    DepartmentCode.SETFILTER(Code, '%1', Team);
                                    DepartmentCode.SETFILTER("ORG Shema", '%1', "Org. Structure");
                                    IF DepartmentCode.FINDSET THEN BEGIN
                                        BrojZapisa := DepartmentCode.COUNT;
                                    END;
                                    IF BrojZapisa > 1 THEN BEGIN
                                        PositionTempInsert.VALIDATE("Disc. Department Name", Rec."Team Description");
                                    END
                                    ELSE BEGIN
                                        PositionTempInsert.VALIDATE("Disc. Department Code", Team);
                                        PositionTempInsert."Disc. Department Name" := '';
                                    END;
                                END;

                                IF (Rec."Group Description" <> '') AND ("Team Description" = '') THEN BEGIN
                                    DepartmentCode.RESET;
                                    DepartmentCode.SETFILTER(Code, '%1', Group);
                                    DepartmentCode.SETFILTER("ORG Shema", '%1', "Org. Structure");
                                    IF DepartmentCode.FINDSET THEN BEGIN
                                        BrojZapisa := DepartmentCode.COUNT;
                                    END;
                                    IF BrojZapisa > 1 THEN BEGIN
                                        PositionTempInsert.VALIDATE("Disc. Department Name", "Group Description");
                                    END
                                    ELSE BEGIN
                                        PositionTempInsert.VALIDATE("Disc. Department Code", Group);
                                        PositionTempInsert."Disc. Department Name" := '';
                                    END;
                                END;

                                IF (Rec."Department Cat. Description" <> '') AND (Rec."Group Description" = '') THEN BEGIN
                                    DepartmentCode.RESET;
                                    DepartmentCode.SETFILTER(Code, '%1', "Department Category");
                                    DepartmentCode.SETFILTER("ORG Shema", '%1', "Org. Structure");
                                    IF DepartmentCode.FINDSET THEN BEGIN
                                        BrojZapisa := DepartmentCode.COUNT;
                                    END;
                                    IF BrojZapisa > 1 THEN BEGIN
                                        PositionTempInsert.VALIDATE("Disc. Department Name", "Department Cat. Description");
                                    END
                                    ELSE BEGIN
                                        PositionTempInsert.VALIDATE("Disc. Department Code", "Department Category");
                                        PositionTempInsert."Disc. Department Name" := '';
                                    END;
                                END;
                                IF ("Management Level" = 7) OR ("Management Level" = 0) THEN BEGIN
                                    IF (Rec."Sector Description" <> '') AND ("Department Cat. Description" = '') THEN
                                        PositionTempInsert.VALIDATE("Disc. Department Code", Rec.Sector);
                                END;


                            END;
                        END;
                        //END;
                        PositionFind.RESET;
                        PositionFind.SETFILTER(Code, '%1', "Position Code");
                        PositionFind.SETFILTER(Description, '%1', "Position Description");
                        PositionFind.SETFILTER("Org. Structure", '%1', "Org. Structure");
                        //PositionFind.SETFILTER("Department Code",'%1',"Department Code");
                        IF PositionFind.FINDLAST THEN BEGIN
                            PositionFind.SETCURRENTKEY(Order);
                            PositionFind.ASCENDING;
                            IF PositionFind.FINDLAST THEN BEGIN
                                IF EVALUATE(ID, PositionFind."Position ID") THEN
                                    "Position ID" := FORMAT(ID + 1);
                                PositionTempInsert."Position ID" := FORMAT(ID + 1);
                                PositionTempInsert.Order := ID + 1;
                                IF PositionFind."Employee No." = '' THEN BEGIN
                                    PositionTempInsert."Position ID" := FORMAT(1);
                                    "Position ID" := FORMAT(1);
                                    PositionTempInsert.Order := 1;
                                    PositionFind.DELETE;
                                END;
                            END;
                        END;
                        "Management Level" := PositionTempInsert."Management Level";
                        "Position Code" := PositionTempInsert.Code;
                        PositionTempInsert.INSERT(FALSE);
                        "Position ID" := PositionTempInsert."Position ID";
                        //  Rec.MODIFY;

                        /*   IF ECL.GET(Rec."No.",Rec."Employee No.",Rec."Org. Structure") THEN BEGIN
                           ECL.RENAME(Rec."No.",Rec."Employee No.",Rec."Org. Structure");
                           ECL.MODIFY;
                           ECL."Position ID":=PositionTempInsert."Position ID";
                           ECL.MODIFY;
                            END;*/



                        EXIT;
                    END
                    //da ppšaljem i rukovodioce

                END;



                PositionTempInsert.RESET;
                PositionTempInsert.SETFILTER("Org. Structure", '%1', "Org. Structure");
                PositionTempInsert.SETFILTER(Description, '%1', "Position Description");
                PositionTempInsert.SETFILTER("Employee No.", '%1', "Employee No.");
                IF PositionTempInsert.FINDFIRST THEN BEGIN
                    "Position ID" := PositionTempInsert."Position ID";
                    "Position Code" := PositionTempInsert.Code;
                    "Management Level" := PositionTempInsert."Management Level";
                    "Key Function" := PositionTempInsert."Key Function";
                    "Control Function" := PositionTempInsert."Control Function";
                    "BJF/GJF" := PositionTempInsert."BJF/GJF";
                END;


                //NK
                IF "Position Description" = '' THEN BEGIN
                    "Position ID" := '';
                    "Position Code" := '';
                    "Management Level" := "Management Level"::" ";
                    "Key Function" := FALSE;
                    "Control Function" := FALSE;
                    "BJF/GJF" := "BJF/GJF"::" ";
                    CLEAR("Manager 1");
                    CLEAR("Manager 2");
                    CLEAR("Manager 1 First Name");
                    CLEAR("Manager 1 Last Name");
                    CLEAR("Manager 1 Position Code");
                    CLEAR("Manager 1 Position ID");
                    CLEAR("Manager 2 First Name");
                    CLEAR("Manager 2 Last Name");
                    CLEAR("Manager 2 Position Code");
                END;


                IF Rec.Active = TRUE THEN BEGIN
                    EmployeeDefaultDimension.RESET;
                    EmployeeDefaultDimension.SETFILTER("No.", '%1', "Employee No.");
                    IF EmployeeDefaultDimension.FINDFIRST THEN
                        EmployeeDefaultDimension.DELETE;
                    IF Rec."Position Description" <> '' THEN BEGIN
                        EmployeeDefaultDimension.INIT;
                        EmployeeDefaultDimension."No." := Rec."Employee No.";
                        EmployeeDefaultDimension.VALIDATE("No.", Rec."Employee No.");
                        EmployeeDefaultDimension.VALIDATE("Dimension Code", 'TC');
                        EmployeeDefaultDimension."Amount Distribution Coeff." := 1;
                        DimensionForPosition.RESET;
                        DimensionForPosition.SETFILTER("Sector  Description", '%1', "Sector Description");
                        DimensionForPosition.SETFILTER("Department Categ.  Description", '%1', "Department Cat. Description");
                        DimensionForPosition.SETFILTER("Group Description", '%1', "Group Description");
                        DimensionForPosition.SETFILTER("Team Description", '%1', "Team Description");
                        DimensionForPosition.SETFILTER("Position Description", '%1', "Position Description");
                        DimensionForPosition.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        IF DimensionForPosition.FINDFIRST THEN BEGIN
                            EmployeeDefaultDimension.VALIDATE("Dimension Value Code", DimensionForPosition."Dimension Value Code");
                            EmployeeDefaultDimension.INSERT;
                        END;
                    END;
                END;

            end;
        }
        field(50320; "Manager Department Code"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."Manager Department Code" WHERE("Manager 1" = FIELD("Manager 1"),
                                                                           "Org. Structure" = FIELD("Org. Structure")));
            Caption = 'Manager Department Code';

        }
        field(50321; "Manager Position Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."Manager Position Code" WHERE(Code = FIELD("Position Code"),
                                                                         "Position ID" = FIELD("Position ID"),
                                                                         "Org. Structure" = FIELD("Org. Structure")));
            Caption = 'Manager Department Code';

        }
        field(50322; "Manager Position ID"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."Manager Position ID" WHERE("Code" = FIELD("Position Code"),
                                                                       "Position ID" = FIELD("Position ID"),
                                                                       "Org. Structure" = FIELD("Org. Structure")));
            Caption = 'Manager Department ID';

        }
        field(50323; "Manager Department Code 2"; Code[20])
        {
            Caption = 'Manager Department Code 2';
            FieldClass = Normal;
        }
        field(50324; "Manager Position Code 2"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."Manager Position Code" WHERE("Code" = FIELD("Manager Position Code"),
                                                                         "Org. Structure" = FIELD("Org. Structure"),
                                                                         "Position ID" = FIELD("Manager Position ID")));
            Caption = 'Manager Department Code';

        }
        field(50325; "Manager Position ID 2"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."Manager Position ID" WHERE(Code = FIELD("Manager Position Code"),
                                                                       "Org. Structure" = FIELD("Org. Structure"),
                                                                       "Position ID" = FIELD("Manager Position ID")));
            Caption = 'Manager Department ID 2';

        }
        field(50326; "Org Dio"; Code[20])
        {
            Caption = 'Org. Part';
            TableRelation = "ORG Dijelovi".Code;

            trigger OnValidate()
            begin

                /*
                
                IF "Org Dio"<>'' THEN BEGIN
                  OrgDijelovi.RESET;
                  OrgDijelovi.SETFILTER(Active,'%1',TRUE);
                  OrgDijelovi.SETFILTER(Code,'%1',"Org Dio");
                  IF OrgDijelovi.FINDFIRST THEN BEGIN
                    // VALIDATE("GF rada code",OrgDijelovi.GF);
                     OrgDijelovi.SETFILTER(GF,"GF rada code");
                     IF OrgDijelovi.FINDFIRST THEN BEGIN
                     "Phisical Department Desc":=OrgDijelovi.City;
                     //"Regional Head Office":=OrgDijelovi."Regionalni Head Office";
                    // "Branch Agency":=OrgDijelovi."Filijala Agencije";
                     Municipality:=OrgDijelovi."Municipality Code";
                       EmpOrg.RESET;
                   EmpOrg.SETFILTER("No.",'%1',"Employee No.");
                    IF EmpOrg.FIND('-') THEN BEGIN
                      EmpOrg."Org Municipality":=Municipality;
                          EmpOrg."Org Entity Code":=OrgDijelovi."Entity Code";
                         EmpOrg."Municipality Code for salary":=OrgDijelovi."Municipality Code for salary";
                       EmpOrg.MODIFY;
                       END;
                
                       END;
                 END;
                END
                ELSE BEGIN
                 //"Regional Head Office":='';
                 // "Branch Agency":='';
                 "Phisical Department Desc":='';
                //VALIDATE("GF rada","GF rada");
                 END;*/

            end;
        }
        field(50327; "Phisical Org Dio"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Department."ORG Dio" WHERE(Code = FIELD("Org Dio")));
            Caption = 'Org. Part';

            TableRelation = Department."ORG Dio";
        }
        field(50328; "Phisical Department Desc"; Text[30])
        {
            Caption = 'Department Description';
            FieldClass = Normal;
        }
        field(50329; "Employee Status"; enum "Employee Status")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Status WHERE("No." = FIELD("Employee No.")));
            Caption = 'Status';


        }
        field(50330; "Phisical Org Dio Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi".Description WHERE("Code" = FIELD("Phisical Org Dio")));
            Caption = 'Org. Part Name';

        }
        field(50331; "Total Netto"; Decimal)
        {
            Caption = 'Total Netto';
        }
        field(50332; "Org Dio Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi".Description WHERE("Code" = FIELD("Org Dio"),
                                                                   GF = FIELD("GF rada code")));
            Caption = 'Org. Part Name';

        }
        field(50333; "Municipality Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Municipality.Name WHERE("Code" = FIELD("Org Municipality of ag")));
            Caption = 'Municipality Name';
            Editable = false;

        }
        field(50334; "Percentage of Fixed Part"; Decimal)
        {
            Caption = 'Percentage of Fixed Part';
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF (("Percentage of Fixed Part" <> 0) AND ("Manager Contract" = TRUE)) THEN BEGIN
                    "Fixed Amount Brutto" := ("Percentage of Fixed Part" / 100) * Brutto;
                    "Fixed Amount Netto" := ("Percentage of Fixed Part" / 100) * Rec.Netto;
                    "Fixed Amount Total Netto" := ("Percentage of Fixed Part" / 100) * "Total Netto";
                    "Variable Amount Brutto" := (1 - ("Percentage of Fixed Part" / 100)) * Brutto;
                    "Variable Amount Netto" := (1 - ("Percentage of Fixed Part" / 100)) * Rec.Netto;
                    "Manager Addition Total Netto" := (1 - ("Percentage of Fixed Part" / 100)) * "Total Netto";
                    "Percentage of Variable" := 100 - "Percentage of Fixed Part";
                END
                ELSE BEGIN
                    "Percentage of Variable" := 0;
                END;
            end;
        }
        field(50335; "Fixed Amount Brutto"; Decimal)
        {
            Caption = 'Fixed Amount Brutto';
        }
        field(50338; "Default Dimension"; Code[20])
        {
            Caption = 'Default Dimension';
        }
        field(50339; "Fixed Amount Netto"; Decimal)
        {
            Caption = 'Fixed Amount Netto';
        }
        field(50340; "Fixed Amount Total Netto"; Decimal)
        {
            Caption = 'Fixed Amount Total Netto';
        }
        field(50341; "Variable Amount Brutto"; Decimal)
        {
            Caption = 'Manager Addition Brutto';
        }
        field(50342; "Variable Amount Netto"; Decimal)
        {
            Caption = 'Fixed Amount Netto';
        }
        field(50343; "Manager Addition Total Netto"; Decimal)
        {
            Caption = 'Manager Addition Total Netto';
        }
        field(50344; "Percentage of Variable"; Decimal)
        {
            Caption = 'Percentage of Fixed Part';
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                "Fixed Amount Brutto" := ("Percentage of Fixed Part" / 100) * Brutto;
                "Fixed Amount Netto" := ("Percentage of Fixed Part" / 100) * Rec.Netto;
                "Fixed Amount Total Netto" := ("Percentage of Fixed Part" / 100) * "Total Netto";
                "Variable Amount Brutto" := (1 - ("Percentage of Fixed Part" / 100)) * Brutto;
                "Variable Amount Netto" := (1 - ("Percentage of Fixed Part" / 100)) * Rec.Netto;
                "Manager Addition Total Netto" := (1 - ("Percentage of Fixed Part" / 100)) * "Total Netto";
            end;
        }
        field(50345; Import; Boolean)
        {
        }
        field(50346; "Wage Change"; Option)
        {
            Caption = 'Wage Change';
            OptionCaption = '  ,Increase-Additional Responsibility,Increase-Replacement,Increase-Additional Work Effort,Increase-Promotion,Increase-Wage After Disciplinary Measure,Increase-Reconcilliation,Increase-Position Change,Increase-Check,,Decrease-Responsibility Decrease,,Decrease-Inadequate Performance,Decrease-Disciplinary Measure,Decrease-Rellocation,Decrease-Reconcilliation';
            OptionMembers = "  ","Increase-Additional Responsibility","Increase-Replacement","Increase-Additional Work Effort","Increase-Promotion","Increase-Wage After Disciplinary Measure","Increase-Reconcilliation","Increase-Position Change","Increase-Check","Decrease-Responsibility Decrease","Decrease-Inadequate Performance","Decrease-Disciplinary Measure","Decrease-Rellocation","Decrease-Reconcilliation";
        }
        field(50347; Contract; Boolean)
        {
            Caption = 'Contract';

            trigger OnValidate()
            begin
                EmployeeContractLedger.SETFILTER("Employee No.", "Employee No.");


                Contract := TRUE;
            end;
        }
        field(50348; "Report Date"; Date)
        {
            Caption = 'Report Date';
        }
        field(50349; "Max Contract Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Employee Contract Ledger"."Starting Date" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Max Contract Date';

        }
        field(50350; "Definite Contract Start Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Min("Employee Contract Ledger"."Starting Date" WHERE("Contract Type" = FILTER(1),
                                                                                "Employee No." = FIELD("Employee No.")));

        }
        field(50351; "Max Position Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Employee Contract Ledger"."Ending Date" WHERE("Employee No." = FIELD("Employee No."),
                                                                              "Position Code" = FIELD("Position Code")));
            Caption = 'Max Contract Date';

        }
        field(50352; "Report Ending Date"; Date)
        {
            Caption = 'Report Ending Date';
        }
        field(50353; "Agency Name"; Text[30])
        {
            Caption = 'Agency Name';
        }
        field(50354; Gender; enum "Employee Gender")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Gender WHERE("No." = FIELD("Employee No.")));
            Caption = 'Gender';


        }
        field(50355; "Birth Date"; Date)
        {
            CalcFormula = Lookup(Employee."Birth Date" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Birth Date';
            FieldClass = FlowField;
        }
        field(50356; Age; Integer)
        {
            Caption = 'Age';
        }
        field(50357; "Org Municipality"; Code[20])
        {

            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi"."Municipality Code for salary" WHERE("Code" = FIELD("Org Dio"),
                                                                                      GF = FIELD("GF rada code")));
            Caption = 'Municipality';
            Editable = false;

        }
        field(50358; "Max Department"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Max("Employee Contract Ledger"."Department Code" WHERE("Employee No." = FIELD("Employee No."),
                                                                                  "Org. Structure" = FIELD("Org. Structure")));

        }
        field(50359; Team; Code[30])
        {
            Caption = 'Team';
            Editable = false;
            FieldClass = Normal;
            TableRelation = TeamT.Code WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin

                //TeamRec.SETFILTER("Org Shema",'%1',"Org Shema");
            end;
        }
        field(50360; "Team Description"; Text[250])
        {
            Caption = 'Team Description';
            Editable = true;
            FieldClass = Normal;
            TableRelation = TeamT.Name WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin


                Department.RESET;
                Department.SETFILTER("Team Description", '%1', "Team Description");
                Department.SETFILTER("ORG Shema", '%1', "Org. Structure");
                IF Department.FIND('-') THEN BEGIN
                    /*Department1.RESET;
                     Department1.SETFILTER ("Team Description",'%1',"Team Description");
                     Department1.SETFILTER("ORG Shema",'%1',"Org. Structure");
                     IF Department1.FINDSET THEN BEGIN
                       Duplicate:=Department1.COUNT;
                       IF Duplicate=2 THEN BEGIN
                         Number:=1;
                         Orginal:=STRLEN("Team Description");
                         Department2.RESET;
                       Department2.SETFILTER ("Team Description",'%1',"Team Description");
                     Department2.SETFILTER("ORG Shema",'%1',"Org. Structure");
                     IF Department2.FINDSET THEN REPEAT
                       IF Number=1 THEN
                       Duzina1:=STRLEN(Department2."Team Description");
                       IF Number=2 THEN
                       Duzina2:=STRLEN(Department2."Team Description");
                       Number:=Number+1;
                       UNTIL Department2.NEXT=0;
                       IF Orginal=Duzina1 THEN BEGIN
                         Department.RESET;
                        Department.SETFILTER ("Team Description",'%1',"Team Description");
                        Department.SETFILTER("ORG Shema",'%1',"Org. Structure");
                        Department.SETFILTER("Entity of Agency",'%1',0);
                     IF Department.FIND('-') THEN BEGIN
                          "Team Description":=Department."Team Description";

                     END;

                        END;
                         IF Orginal=Duzina2 THEN BEGIN
                         Department.RESET;
                        Department.SETFILTER ("Team Description",'%1',"Team Description");
                        Department.SETFILTER("ORG Shema",'%1',"Org. Structure");
                        Department.SETFILTER("Entity of Agency",'%1',1);
                     IF Department.FIND('-') THEN BEGIN
                          "Team Description":=Department."Team Description";

                     END;

                        END;
                         END;
                          END;*/


                    "Team Description" := Department."Team Description";
                    IF "Team Description" <> '' THEN BEGIN
                        "Department Name" := Department."Team Description";
                        "Org Belongs" := Department."Team Description";
                        Izmjena := TRUE;
                    END;
                    IF "Team Description" <> '' THEN BEGIN
                        VALIDATE(Team, Department."Team Code");
                        VALIDATE("Department Code", Department."Team Code");
                        VALIDATE(Group, Department."Group Code");
                        VALIDATE("Group Description", Department."Group Description");
                        VALIDATE("Department Category", Department."Department Category");
                        VALIDATE("Department Cat. Description", Department."Department Categ.  Description");
                        VALIDATE(Sector, Department.Sector);
                        VALIDATE("Sector Description", Department."Sector  Description");
                        //    VALIDATE(Description,"Team Description");
                    END;
                END;

                IF "Team Description" = '' THEN BEGIN
                    "Sector Code" := '';
                    Sector := '';
                    "Department Cat. Description" := '';
                    "Department Category" := '';
                    Group := '';
                    "Group Description" := '';
                    Team := '';
                    "Team Description" := '';
                    "Department Code" := '';
                    "Department Name" := '';
                    "Position Description" := '';
                    "Position Code" := '';
                    "Org Belongs" := '';
                    "Management Level" := 0;
                    "Key Function" := FALSE;
                    "Control Function" := FALSE;
                    "Sector Description" := '';
                END;



            end;
        }
        field(50361; "Management Level"; Option)
        {
            Caption = 'Management Level';
            OptionCaption = ' ,B,B1,B2,B3,B4,CEO,E,Exe';
            OptionMembers = " ",B,B1,B2,B3,B4,CEO,E,Exe;
        }
        field(50362; "Agremeent Code"; Code[10])
        {
            Caption = 'Agremeent Code';
            Editable = false;
        }
        field(50363; "Agreement Name"; Text[200])
        {
            Caption = 'Agreement Name';
            TableRelation = "Document Register"."Document Description" WHERE("Group" = FIELD("Contract Type Name"),
                                                                              "Show Template" = CONST(TRUE));

            trigger OnValidate()
            begin
                MODIFY;
                DocumentReg.RESET;
                DocumentReg.SETFILTER("Document Description", '%1', "Agreement Name");
                IF DocumentReg.FINDFIRST THEN BEGIN
                    "Agremeent Code" := DocumentReg."Agreement Code";
                END
                ELSE BEGIN
                    "Agremeent Code" := DocumentReg."Agreement Code";
                END;


                IF "Employee No." <> '' THEN BEGIN
                    IF "Agreement Name" <> '' THEN BEGIN
                        ECLNumber.RESET;
                        ECLNumber.SETCURRENTKEY("No.");
                        ECLNumber.ASCENDING;
                        ECLNumber.SETFILTER("Employee No.", '%1', "Employee No.");
                        ECLNumber.SETFILTER("No.", '%1', Rec."No.");
                        IF ECLNumber.FINDLAST THEN BEGIN
                            ECLBefore.RESET;
                            ECLBefore.SETCURRENTKEY("Number of protocol for documen");
                            ECLBefore.ASCENDING;
                            IF ECLBefore.FINDLAST THEN BEGIN
                                if ECLBefore."Number of protocol for documen" = '' then
                                    NumberOfProt := '00000000'
                                else
                                    NumberOfProt := COPYSTR(ECLBefore."Number of protocol for documen", 1, STRLEN(ECLBefore."Number of protocol for documen") - 4);
                                Rec."Number of protocol for documen" := INCSTR(NumberOfProt) + FORMAT(DATE2DMY(TODAY, 3));
                            END;
                        END;
                    END;
                END;
                MODIFY;


                "Registration Date" := "Starting Date";
                IF ((USERID <> 'MBDOM\HRAPP') AND (USERID <> 'MBDOM\FEDJA.BOGDANOVIC')) THEN
                    "Operator No." := USERID;


                CLEAR(FileManagement);
                // CLEAR(Contract1);
                /* CLEAR(Contract3);
                 CLEAR(Contract11);
                 CLEAR(Contract21);
                 CLEAR(Contract22);
                 CLEAR(Contract23);
                 CLEAR(Contract24);
                 CLEAR(Contract25);
                 CLEAR(Contract99);
                 CLEAR(Contract101);
                 CLEAR(Contract103);
                 CLEAR(Contract111);
                 CLEAR(Contract119);
                 CLEAR(Contract122);
                 CLEAR(Contract127);
                 CLEAR(Contract128);
                 CLEAR(Contract214);
                 CLEAR(Contract299);
                 CLEAR(Contract301);
                 CLEAR(Contract309);
                 CLEAR(Contract310);
                 CLEAR(Contract311);
                 CLEAR(Contract328);
                 CLEAR(Contract402);
                 CLEAR(Contract702);
                 CLEAR(Contract711);
                 CLEAR(Contract721);
                 CLEAR(Contract722);
                 CLEAR(Contract780);
                 CLEAR(Contract789);
                 CLEAR(Contract801);
                 CLEAR(Contract5056);
                 CLEAR(Contract88);
                 CLEAR(Contract87);
                 CLEAR(Contract115);
                 CLEAR(Contract129);
                 CLEAR(Contract187);
                 CLEAR(Contract188);
                 CLEAR(Contract189);
                 CLEAR(Contract190);
                 CLEAR(Contract191);
                 CLEAR(Contract192);
                 CLEAR(Contract193);
                 CLEAR(Contract215);
                 CLEAR(Contract216);
                 CLEAR(Contract291);
                 CLEAR(Contract292);
                 CLEAR(Contract296);
                 CLEAR(Contract297);
                 CLEAR(Contract298);
                 CLEAR(Contract319);
                 CLEAR(Contract322);
                 CLEAR(Contract324);
                 CLEAR(Contract406);
                 CLEAR(Contract407);
                 CLEAR(Contract408);
                 CLEAR(Contract410);
                 CLEAR(Contract412);
                 CLEAR(Contract415);
                 CLEAR(Contract416);
                 CLEAR(Contract417);
                 CLEAR(Contract418);
                 CLEAR(Contract491);
                 CLEAR(Contract496);
                 CLEAR(Contract497);
                 CLEAR(Contract498);
                 CLEAR(Contract499);*/

                // Auto Uvoz
                DR.RESET;
                //DR.SETFILTER("Agreement Code",'%1',Rec."Agremeent Code");
                DR.SETFILTER("Document Description", '%1', Rec."Agreement Name");
                DR.SETFILTER("Show Template", '%1', TRUE);

                IF DR.FINDLAST THEN BEGIN
                    IF DR."NAV Agreement Code" = 50005 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(format(CRL."Report ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //    Contract1.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //   Contract1.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    //AKO JE DR."NAV Agreement Code"=3

                    IF DR."NAV Agreement Code" = 3 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(format(CRL."Report ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //  Contract3.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //   Contract3.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;


                    //AKO JE DR."NAV Agreement Code"=11
                    IF DR."NAV Agreement Code" = 11 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."Report ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK  Contract11.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract11.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    //AKO JE DR."NAV Agreement Code"=21
                    IF DR."NAV Agreement Code" = 21 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."Report ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract21.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract21.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;


                    //ako je dr."NAV Agreement Code"=22

                    IF DR."NAV Agreement Code" = 22 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract22.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract22.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    //AKO JE DR."NAV Agreement Code"=23
                    IF DR."NAV Agreement Code" = 23 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract23.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract23.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 88 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract88.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract88.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 87 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract87.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract87.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;


                    IF DR."NAV Agreement Code" = 115 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract115.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract115.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 129 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract129.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract129.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;



                    IF DR."NAV Agreement Code" = 187 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract187.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract187.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;



                    IF DR."NAV Agreement Code" = 188 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract188.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract188.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;


                    IF DR."NAV Agreement Code" = 189 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract189.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract189.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 190 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract190.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract190.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    IF DR."NAV Agreement Code" = 191 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract191.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract191.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    IF DR."NAV Agreement Code" = 192 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract192.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract192.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 193 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract193.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract193.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 215 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract215.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract215.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 216 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract216.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract216.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 291 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract291.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract291.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 292 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract292.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract292.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 296 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract296.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract296.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 297 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract297.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract297.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;


                    IF DR."NAV Agreement Code" = 298 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract298.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract298.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 319 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract319.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract319.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 322 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract322.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK  Contract322.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 324 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract324.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract324.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 406 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract406.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract406.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 407 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract407.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract407.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 408 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract408.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract408.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;


                    IF DR."NAV Agreement Code" = 410 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract410.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract410.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 412 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract412.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract412.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 415 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract415.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract415.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 416 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract416.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract416.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 417 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract417.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract417.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 418 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract418.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract418.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;


                    IF DR."NAV Agreement Code" = 491 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract491.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract491.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 496 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract496.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract496.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 497 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract497.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract497.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 498 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract498.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract498.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    IF DR."NAV Agreement Code" = 499 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract499.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract499.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    //AKO JE DR."NAV Agreement Code"=24
                    IF DR."NAV Agreement Code" = 24 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract24.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract24.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    //AKO JE DR."NAV Agreement Code"=25
                    IF DR."NAV Agreement Code" = 25 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract25.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract25.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;


                    //AKO JE DR."NAV Agreement Code"=99
                    IF DR."NAV Agreement Code" = 99 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', "Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', "Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract99.SetParam("Employee No.", "Agremeent Code", "No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract99.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    //AKO JE DR."NAV Agreement Code"=101
                    IF DR."NAV Agreement Code" = 101 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract101.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract101.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    //AKO JE DR."NAV Agreement Code"=103

                    IF DR."NAV Agreement Code" = 103 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract103.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract103.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    //AKO JE DR."NAV Agreement Code"=111
                    IF DR."NAV Agreement Code" = 111 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract111.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract111.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    //AKO JE DR."NAV Agreement Code"=119
                    IF DR."NAV Agreement Code" = 119 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract119.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract119.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    //AKO JE DR."NAV Agreement Code"=122
                    IF DR."NAV Agreement Code" = 122 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract122.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract122.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    //AKO JE DR."NAV Agreement Code"=127
                    IF DR."NAV Agreement Code" = 127 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract127.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract127.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    //AKO JE DR."NAV Agreement Code"=128
                    IF DR."NAV Agreement Code" = 128 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract128.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract128.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    //AKO JE DR."NAV Agreement Code"=214
                    IF DR."NAV Agreement Code" = 214 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK  Contract214.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract214.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    //AKO JE DR."NAV Agreement Code"=299
                    IF DR."NAV Agreement Code" = 299 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract299.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK  Contract299.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    //AKO JE DR."NAV Agreement Code"=301

                    IF DR."NAV Agreement Code" = 301 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract301.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract301.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    //AKO JE DR."NAV Agreement Code"=309
                    IF DR."NAV Agreement Code" = 309 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract309.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract309.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    //AKO JE DR."NAV Agreement Code"=310
                    IF DR."NAV Agreement Code" = 310 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract310.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract310.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    //AKO JE DR."NAV Agreement Code"=311

                    IF DR."NAV Agreement Code" = 311 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract311.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract311.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    //AKO JE DR."NAV Agreement Code"=328

                    IF DR."NAV Agreement Code" = 328 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract328.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract328.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;


                    //AKO JE DR."NAV Agreement Code"=402
                    IF DR."NAV Agreement Code" = 402 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract402.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract402.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    //AKO JE DR."NAV Agreement Code"=702


                    IF DR."NAV Agreement Code" = 702 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract702.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract702.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    //AKO JE DR."NAV Agreement Code"=711

                    IF DR."NAV Agreement Code" = 711 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract711.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract711.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;

                    //AKO JE DR."NAV Agreement Code"=721

                    IF DR."NAV Agreement Code" = 721 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract721.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract721.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    //AKO JE DR."NAV Agreement Code"=722
                    IF DR."NAV Agreement Code" = 722 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract722.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract722.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;


                    //AKO JE DR."NAV Agreement Code"=780
                    IF DR."NAV Agreement Code" = 780 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract780.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract780.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;




                    //AKO JE DR."NAV Agreement Code"=5056

                    IF DR."NAV Agreement Code" = 5056 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract5056.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract5056.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;


                    IF DR."NAV Agreement Code" = 801 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract801.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract801.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                    //AKO JE DR."NAV Agreement Code"=789
                    IF DR."NAV Agreement Code" = 789 THEN BEGIN


                        CRL.SETFILTER("Report ID", '%1', DR."NAV Agreement Code");
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract789.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract789.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);

                            IF "Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment(FALSE);
                                "Attachment No." := 0;
                                MODIFY(FALSE);

                                COMMIT;
                            END;

                            NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                            IF NewAttachNo <> 0 THEN BEGIN
                                "Attachment No." := NewAttachNo;

                                COMMIT;
                            END;


                        END;
                        ImportAttachment;
                    END;
                END;




            end;
        }
        field(50364; "Contract Type Name"; Text[100])
        {
            Caption = 'Contract Type Description';
            TableRelation = "Employment Contract".Description;
            Editable = false;

            trigger OnValidate()
            begin

                IF "Contract Type Name" <> '' THEN BEGIN
                    EmploymentContract.SETFILTER(Description, '%1', "Contract Type Name");
                    IF EmploymentContract.FINDFIRST THEN BEGIN
                        //VALIDATE("Contract Type",EmploymentContract.Code)
                        "Contract Type" := EmploymentContract.Code;
                    END;
                END
                ELSE BEGIN
                    // VALIDATE("Contract Type",'');
                    "Contract Type" := '';
                END;



                ECL.SETFILTER("Employee No.", "Employee No.");
                IF ECL.FINDLAST THEN BEGIN
                    Emp.RESET;
                    Emp.SETFILTER("No.", "Employee No.");
                    IF Emp.FINDFIRST() THEN BEGIN
                        Emp."Emplymt. Contract Code" := "Contract Type";
                        Emp.MODIFY;
                    END;
                END;



                /*IF "Contract Type"<>'' THEN BEGIN
                 IF "Contract Type"='2' THEN BEGIN
                   "Testing Period":=TRUE;
                   "Testing Period Starting Date":=TODAY;
                   END
                   ELSE
                 IF "Contract Type"='5' THEN BEGIN
                  "Testing Period":=TRUE;
                   "Testing Period Starting Date":=TODAY;
                   END
                   ELSE BEGIN
                   "Testing Period":=FALSE;
                   "Testing Period Starting Date":=0D;
                    "Testing Period Ending Date":=0D;
                     "Probation Days":=0;
                  "Probation Months":=0;
                     END;
                   END;
                    */
                EngagementType.RESET;
                EngagementType.SETFILTER(Description, '%1', Rec."Engagement Type");
                IF EngagementType.FINDFIRST THEN BEGIN
                    IF (EngagementType.Code = '5') OR (EngagementType.Code = '2') THEN BEGIN

                        "Testing Period" := TRUE;
                        "Testing Period Starting Date" := "Starting Date";
                    END
                    ELSE BEGIN
                        "Testing Period" := FALSE;
                        "Testing Period Starting Date" := 0D;
                    END;
                END;


                IF ("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI') THEN BEGIN
                    RecDate1.RESET;
                    RecDate1.SETRANGE("Period Type", RecDate1."Period Type"::Date);
                    RecDate1.SETRANGE("Period Start", "Starting Date", "Ending Date");
                    IF RecDate1.FINDSET THEN BEGIN
                        LastFoundDate1 := "Starting Date";
                        // *** find count of years ***
                        TempDate1 := CALCDATE('<+1Y-1D>', LastFoundDate1);
                        Found1 := TRUE;
                        CountYears1 := 0;
                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                            CountYears1 := 1;
                            LastFoundDate1 := TempDate1;
                            TempDate1 := CALCDATE('<+2Y-1D>', "Starting Date");
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountYears1 := 2;
                                LastFoundDate1 := TempDate1;
                            END;
                        END;

                        // *** find count of months ***
                        IF CountYears1 = 0 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M-1D>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<9M-1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        // *** find count of months ***
                        IF CountYears1 = 1 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<1Y+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<+1Y+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<1Y+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<1Y+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<1Y+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<1Y+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<1Y+5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+1Y+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<1Y+6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<1Y+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<1Y+7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<1Y+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<1Y+8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<+1Y+8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<1Y+9M+1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<1Y+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<1Y+10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<+1Y+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<1Y+11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<1Y+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        // *** find count of months ***
                        IF CountYears1 = 2 THEN BEGIN
                            TempDate1 := CALCDATE('<+1M>', LastFoundDate1);
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountMonths1 := 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<2Y+2M-1D>', "Starting Date");
                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                    TempDate1 := CALCDATE('<2Y+2M>', "Starting Date");
                                END;
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountMonths1 := 2;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<2Y+3M-1D>', "Starting Date");
                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                        TempDate1 := CALCDATE('<2Y+3M>', "Starting Date");
                                    END;
                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                        CountMonths1 := 3;
                                        LastFoundDate1 := TempDate1;
                                        TempDate1 := CALCDATE('<2Y+4M-1D>', "Starting Date");
                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                            TempDate1 := CALCDATE('<2Y+4M>', "Starting Date");
                                        END;
                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                            CountMonths1 := 4;
                                            LastFoundDate1 := TempDate1;
                                            TempDate1 := CALCDATE('<2Y+5M-1D>', "Starting Date");
                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                TempDate1 := CALCDATE('<+2Y+5M>', "Starting Date");
                                            END;
                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                CountMonths1 := 5;
                                                LastFoundDate1 := TempDate1;
                                                TempDate1 := CALCDATE('<2Y+6M-1D>', "Starting Date");
                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                    TempDate1 := CALCDATE('<2Y+6M>', "Starting Date");
                                                END;
                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                    CountMonths1 := 6;
                                                    LastFoundDate1 := TempDate1;
                                                    TempDate1 := CALCDATE('<2Y+7M-1D>', "Starting Date");
                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                        TempDate1 := CALCDATE('<2Y+7M>', "Starting Date");
                                                    END;
                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                        CountMonths1 := 7;
                                                        LastFoundDate1 := TempDate1;
                                                        TempDate1 := CALCDATE('<2Y+8M-1D>', "Starting Date");
                                                        IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                            TempDate1 := CALCDATE('<2Y+8M>', "Starting Date");
                                                        END;
                                                        IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                            CountMonths1 := 8;
                                                            LastFoundDate1 := TempDate1;
                                                            TempDate1 := CALCDATE('<2Y+9M+1D>', "Starting Date");
                                                            IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                TempDate1 := CALCDATE('<+2Y+9M>', "Starting Date");
                                                            END;
                                                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                CountMonths1 := 9;
                                                                LastFoundDate1 := TempDate1;
                                                                TempDate1 := CALCDATE('<2Y+10M-1D>', "Starting Date");
                                                                IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                    TempDate1 := CALCDATE('<2Y+10M>', "Starting Date");
                                                                END;
                                                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                    CountMonths1 := 10;
                                                                    LastFoundDate1 := TempDate1;
                                                                    TempDate1 := CALCDATE('<2Y+11M-1D>', "Starting Date");
                                                                    IF ((DATE2DMY("Starting Date", 1) = 31) AND ((DATE2DMY(TempDate1, 1) = 29) OR (DATE2DMY(TempDate1, 1) = 27))) THEN BEGIN
                                                                        TempDate1 := CALCDATE('<2Y+11M>', "Starting Date");
                                                                    END;
                                                                    IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                                                        CountMonths1 := 11;
                                                                        LastFoundDate1 := TempDate1;
                                                                    END;
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                            // *** find count of days ***
                            TempDate1 := CALCDATE('<+1D>', LastFoundDate1);
                            Found1 := TRUE;
                            REPEAT
                                IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                    CountDays1 += 1;
                                    LastFoundDate1 := TempDate1;
                                    TempDate1 := CALCDATE('<+1D>', TempDate1);
                                END ELSE
                                    Found1 := FALSE;
                            UNTIL NOT Found1;
                        END;
                        "Work Days" := CountDays1;
                        "Work Months" := CountMonths1;
                        "Work Years" := CountYears1;
                    END;
                END
                ELSE BEGIN
                    "Work Days" := 0;
                    "Work Months" := 0;
                    "Work Years" := 0;
                END;
                IF ("Starting Date" = 0D) OR ("Ending Date" = 0D) THEN BEGIN
                    "Work Days" := 0;
                    "Work Months" := 0;
                    "Work Years" := 0;
                END;

                IF ("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI') THEN BEGIN
                    IF
                    ("Work Months" = 0) AND ("Work Years" = 0) AND ("Ending Date" <> 0D) AND ("Starting Date" <> 0D) THEN BEGIN
                        CountDays1 := 1;
                        TempDate1 := CALCDATE('<+1D>', "Starting Date");
                        Found1 := TRUE;
                        REPEAT
                            IF (TempDate1 <= "Ending Date") AND (RecDate1.GET(RecDate1."Period Type"::Date, TempDate1)) THEN BEGIN
                                CountDays1 += 1;
                                LastFoundDate1 := TempDate1;
                                TempDate1 := CALCDATE('<+1D>', TempDate1);
                            END ELSE
                                Found1 := FALSE;
                        UNTIL NOT Found1;
                        "Work Days" := CountDays1;
                    END;
                END;



                EngagementType.RESET;
                EngagementType.SETFILTER(Description, '%1', Rec."Engagement Type");
                IF EngagementType.FINDFIRST THEN BEGIN
                    IF (EngagementType.Code = '5') OR (EngagementType.Code = '2') THEN BEGIN

                        "Testing Period" := TRUE;
                        "Testing Period Starting Date" := "Starting Date";
                    END
                    ELSE BEGIN
                        "Testing Period" := FALSE;
                        "Testing Period Starting Date" := 0D;
                    END;
                END;
                IF "Employee No." <> '' THEN BEGIN
                    "Order By" := 5;
                    /*IF "Position Description"='VD*' THEN
                    "Order By":=1;*/
                    IF STRPOS("Position Description", 'VD') <> 0 THEN
                        "Order By" := 1;
                    IF ("Additional Benefits") AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 2;
                    IF ("Temporary disposition" = TRUE) AND ("Additional Benefits" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 3;
                    IF (("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI')) AND ("Additional Benefits" = FALSE) AND ("Temporary disposition" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 4
                END;

            end;
        }
        field(50365; "Key Function"; Boolean)
        {
            Caption = 'Key Function';
        }
        field(50366; "IS Risk Materiality"; Option)
        {
            OptionMembers = " ","Less Material",Material;
        }
        field(50367; "Contract Phase"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Contract Phase t"."Contract Phase" WHERE("Employee No." = FIELD("Employee No."),
                                                                            "Contract Ledger Entry No." = FIELD("No."),
                                                                            Active = FILTER(true)));
            Caption = 'Contract Phase';

            OptionCaption = ' ,Control,Management-Signature,Worker-Signature,Delayed';
            OptionMembers = " ",Control,"Management-Signature","Worker-Signature",Delayed;

            trigger OnValidate()
            begin
                //"Contract Phase Date":=TODAY;
                //"Contract Phase Time":=TIME;
            end;
        }
        field(50368; "Contract Phase Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Contract Phase t"."Contract Phase Date" WHERE("Contract Ledger Entry No." = FIELD("No."),
                                                                                 "Employee No." = FIELD("Employee No."),
                                                                                 Active = FILTER(true)));
            Caption = 'Contract Phase Date';
            Editable = false;

        }
        field(50369; "Contract Phase Time"; Time)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Contract Phase t"."Contract Phase Time" WHERE("Contract Ledger Entry No." = FIELD("No."),
                                                                                 "Employee No." = FIELD("Employee No."),
                                                                                 Active = FILTER(true)));
            Caption = 'Contract Phase Time';
            Editable = false;

        }
        field(50370; "Percentage of Fixed"; Decimal)
        {
            Caption = 'Percentage of Fixed Part';
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                "Fixed Amount Brutto" := ("Percentage of Fixed Part" / 100) * Brutto;
                "Fixed Amount Netto" := ("Percentage of Fixed Part" / 100) * Rec.Netto;
                "Fixed Amount Total Netto" := ("Percentage of Fixed Part" / 100) * "Total Netto";
                "Variable Amount Brutto" := (1 - ("Percentage of Fixed Part" / 100)) * Brutto;
                "Variable Amount Netto" := (1 - ("Percentage of Fixed Part" / 100)) * Rec.Netto;
                "Manager Addition Total Netto" := (1 - ("Percentage of Fixed Part" / 100)) * "Total Netto";
            end;
        }
        field(50371; "Key Function From"; Date)
        {
            Caption = 'Key Function From';

            trigger OnValidate()
            begin
                IF "Control Function To" <> 0D THEN BEGIN
                    IF "Control Function From" = 0D THEN
                        ERROR(Text000);
                    IF "Control Function To" < "Control Function From" THEN
                        ERROR(Text001);
                END;
            end;
        }
        field(50372; "Key Function To"; Date)
        {
            Caption = 'Key Function To';

            trigger OnValidate()
            begin
                IF "Control Function To" <> 0D THEN BEGIN
                    IF "Control Function From" = 0D THEN
                        ERROR(Text000);
                    IF "Control Function To" < "Control Function From" THEN
                        ERROR(Text001);
                END;
            end;
        }
        field(50373; "Regionalni Head Office"; Option)
        {
            Caption = 'Regiona officel/Head Office';
            OptionCaption = ' ,Regional office,Head office';
            OptionMembers = " ","Regional Head Office","Head office";
        }
        field(50374; "Branch Agency"; Option)
        {
            Caption = 'Branch Agency';
            Editable = false;
            OptionCaption = ' ,Branch,Agency';
            OptionMembers = " ",Branch,Agency;

            trigger OnValidate()
            begin
                IF "Branch Agency" = 0 THEN BEGIN
                    VALIDATE("Org Unit Name", '');
                    VALIDATE("GF of work Description", '');
                END;
                IF "Branch Agency" = 1 THEN BEGIN
                    VALIDATE("Org Unit Name", '');
                    VALIDATE("Org Unit Name", "Org Unit Name");
                END;
                IF "Branch Agency" = 2 THEN BEGIN
                    VALIDATE("GF of work Description", '');
                    VALIDATE("GF of work Description", "GF of work Description");
                END;
            end;
        }
        field(50375; "Work Days"; Integer)
        {
            Caption = 'Work Days on definitely';
            Editable = true;
        }
        field(50376; "Work Months"; Integer)
        {
            Caption = 'Work Months on definitely';
            Editable = true;
        }
        field(50378; "Date of sending notification"; Date)
        {
            Caption = 'Date of sending notification';
        }
        field(50379; "Notification send"; Boolean)
        {
            Caption = 'Notification send';

            trigger OnValidate()
            begin
                IF "Notification send" = TRUE THEN
                    "Date of sending notification" := TODAY
                ELSE
                    "Date of sending notification" := 0D;
            end;
        }
        field(50380; "Temporary disposition"; Boolean)
        {
            Caption = 'Temporary disposition';

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN BEGIN
                    "Order By" := 5;
                    /*IF "Position Description"='VD*' THEN
                    "Order By":=1;*/
                    IF STRPOS("Position Description", 'VD') <> 0 THEN
                        "Order By" := 1;
                    IF ("Additional Benefits") AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 2;
                    IF ("Temporary disposition" = TRUE) AND ("Additional Benefits" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 3;
                    IF (("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI')) AND ("Additional Benefits" = FALSE) AND ("Temporary disposition" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 4
                END;

            end;
        }
        field(50381; "Employee Benefits"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Misc. Article Information" WHERE("Employee No." = FIELD("Employee No."),
                                                                   "Emp. Contract Ledg. Entry No." = FIELD("No."),
                                                                   "Org Shema" = FIELD("Org. Structure")));
            Caption = 'Employee Benefits';
            Editable = false;

        }
        field(50382; "Internal ID"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Internal ID" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Internal ID';

        }
        field(50383; "GF rada code"; Code[10])
        {
            Caption = 'GF of works';
            TableRelation = "ORG Dijelovi".GF;

            trigger OnValidate()
            begin

                /*IF ("GF rada"<>'') AND ("Org Dio"='') THEN BEGIN
                  OrgDijelovi.RESET;
                  OrgDijelovi.SETFILTER(Active,'%1',TRUE);
                  OrgDijelovi.SETFILTER(GF,"GF rada");
                  IF OrgDijelovi.FINDFIRST THEN BEGIN
                  "Phisical Department Desc":=OrgDijelovi.City;
                  "Regional Head Office":=OrgDijelovi."Regionalni Head Office";
                  Municipality:=OrgDijelovi."Municipality Code";
                EmpOrg.RESET;
                   EmpOrg.SETFILTER("No.",'%1',"Employee No.");
                    IF EmpOrg.FIND('-') THEN BEGIN
                      EmpOrg."Org Municipality":=Municipality;
                      EmpOrg."Org Entity Code":=OrgDijelovi."Entity Code";
                      EmpOrg."Municipality Code for salary":=OrgDijelovi."Municipality Code for salary";
                       EmpOrg.MODIFY;
                       END;
                END;
                END
                ELSE BEGIN
                 "Regional Head Office":='';
                  "Branch Agency":='';
                  "Phisical Department Desc":='';
                 END;
                 */

            end;
        }
        field(50384; "Work Years"; Integer)
        {
            Caption = 'Work Years on definitely';
            Editable = true;
        }
        field(50385; "Probation Year"; Integer)
        {
            Caption = 'Probation Years';
            Editable = false;
        }
        field(50386; Region; Integer)
        {
            FieldClass = FlowField;
            //    BlankZero = true;
            CalcFormula = Lookup("ORG Dijelovi".Region WHERE("Code" = FIELD("Org Dio"),
                                                              "GF" = FIELD("GF rada code")));
            Caption = 'Region';
            Editable = false;

        }
        field(50387; "Org Entity Code"; Code[10])
        {
            CalcFormula = Lookup("ORG Dijelovi"."Entity Code" WHERE("Code" = FIELD("Org Dio"),
                                                                     "GF" = FIELD("GF rada code")));
            Caption = 'Org Entity Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50388; "Municipality Code for salary"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi"."Municipality Code for salary" WHERE("Code" = FIELD("Org Dio"),
                                                                                      "GF" = FIELD("GF rada code")));
            Caption = 'Municipality Code for salary';

        }
        field(50389; "Org Unit Name"; Text[100])
        {
            Caption = 'Org Unit Name';
            TableRelation = "ORG Dijelovi".Description WHERE("Branch Agency" = FIELD("Branch Agency"),
                                                              "Code" = FILTER(<> ''));

            trigger OnValidate()
            begin
                IF "Org Unit Name" <> '' THEN BEGIN

                    /*IF "Org Dio"<>'' THEN BEGIN*/
                    OrgDijelovi.RESET;
                    OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                    /* OrgDijelovi.SETFILTER(Code,'%1',"Org Dio");*/
                    OrgDijelovi.SETFILTER(Description, '%1', "Org Unit Name");
                    IF OrgDijelovi.FINDFIRST THEN BEGIN
                        //VALIDATE("GF rada code",OrgDijelovi.GF);
                        "GF rada code" := OrgDijelovi.GF;
                        "GF of work Description" := '';
                        //VALIDATE("GF of work Description",OrgDijelovi.Description);
                        OrgDijelovi.SETFILTER(GF, "GF rada code");
                        IF OrgDijelovi.FINDFIRST THEN BEGIN
                            "Org Dio" := OrgDijelovi.Code;
                            "Phisical Department Desc" := OrgDijelovi.City;
                            "Regionalni Head Office" := OrgDijelovi."Regionalni Head Office";
                            //"Branch Agency":=OrgDijelovi."Branch Agency";
                            Municipality := OrgDijelovi."Municipality Code";
                            EmpOrg.RESET;
                            EmpOrg.SETFILTER("No.", '%1', "Employee No.");
                            IF EmpOrg.FIND('-') THEN BEGIN
                                EmpOrg.Region := OrgDijelovi.Region;
                                EmpOrg."Org Municipality" := OrgDijelovi."Municipality Code of agency";
                                EmpOrg."Org Entity Code" := OrgDijelovi."Entity Code";
                                EmpOrg."Phisical Department Desc" := EmpOrg."Phisical Department Desc";
                                EmpOrg."Municipality Code for salary" := OrgDijelovi."Municipality Code for salary";
                                EmpOrg."Org Jed" := "Org Dio";
                                EmpOrg.GF := "GF rada code";
                                IF EmpOrg."Org Entity Code" = 'FBIH'
                                  THEN
                                    EmpOrg."Contribution Category Code" := 'FBIH';
                                IF ((EmpOrg."Org Entity Code" = 'RS'))
                                 THEN
                                    EmpOrg."Contribution Category Code" := 'RS';
                                /*IF EmpOrg."Org Entity Code"='BD'
                                THEN EmpOrg."Contribution Category Code":='BDPIOFBIH';*/

                                IF Active = TRUE THEN begin
                                    EmpOrg.validate("Benefit Coefficient", EmpOrg."Benefit Coefficient");
                                    EmpOrg.MODIFY;
                                end;
                            END;
                        END;
                    END;
                END
                ELSE BEGIN
                    "Regionalni Head Office" := 0;
                    "Phisical Department Desc" := '';
                    "GF of work Description" := '';
                    "GF rada code" := '';
                    "Org Dio" := '';
                    VALIDATE("GF of work Description", "GF of work Description");
                    EmpOrg.SETFILTER("No.", '%1', "Employee No.");
                    IF EmpOrg.FIND('-') THEN BEGIN

                        EmpOrg."Org Municipality" := '';
                        EmpOrg."Municipality Code for salary" := '';
                        EmpOrg."Org Entity Code" := '';
                        EmpOrg.Region := 0;
                        EmpOrg."Org Jed" := '';
                        EmpOrg.GF := '';
                        IF OrgDijelovi."Entity Code" = ''
                      THEN
                            EmpOrg."Contribution Category Code" := '';
                        IF Active = TRUE THEN begin
                            EmpOrg.validate("Benefit Coefficient", EmpOrg."Benefit Coefficient");
                            EmpOrg.MODIFY;
                        end;
                    END;
                END;

            end;
        }
        field(50390; "GF of work Description"; Text[100])
        {
            Caption = 'GF of works';
            TableRelation = "ORG Dijelovi".Description WHERE("Branch Agency" = FIELD("Branch Agency"),
                                                              "Code" = FILTER(''));

            trigger OnValidate()
            begin
                IF ("GF of work Description" <> '') AND ("Org Unit Name" = '') THEN BEGIN

                    /*IF ("GF rada"<>'') AND ("Org Dio"='') THEN BEGIN*/
                    OrgDijelovi.RESET;
                    OrgDijelovi.SETFILTER(Active, '%1', TRUE);
                    /*OrgDijelovi.SETFILTER(GF,"GF rada");*/
                    OrgDijelovi.SETFILTER(Description, "GF of work Description");
                    IF OrgDijelovi.FINDFIRST THEN BEGIN
                        "GF rada code" := OrgDijelovi.GF;
                        "Phisical Department Desc" := OrgDijelovi.City;
                        "Org Dio" := OrgDijelovi.Code;

                        Municipality := OrgDijelovi."Municipality Code";
                        "Regionalni Head Office" := OrgDijelovi."Regionalni Head Office";
                        //"Branch Agency":=OrgDijelovi."Branch Agency";
                        EmpOrg.RESET;
                        EmpOrg.SETFILTER("No.", '%1', "Employee No.");
                        IF EmpOrg.FIND('-') THEN BEGIN
                            EmpOrg.Region := OrgDijelovi.Region;
                            EmpOrg."Org Dio" := OrgDijelovi.Code;
                            EmpOrg."Org Municipality" := OrgDijelovi."Municipality Code of agency";
                            EmpOrg."Org Entity Code" := OrgDijelovi."Entity Code";
                            EmpOrg."Municipality Code for salary" := OrgDijelovi."Municipality Code for salary";
                            EmpOrg."Phisical Department Desc" := EmpOrg."Phisical Department Desc";
                            EmpOrg."Municipality Code for salary" := OrgDijelovi."Municipality Code for salary";
                            IF "Org Dio" <> '' THEN
                                EmpOrg."Org Jed" := "Org Dio";
                            EmpOrg.GF := "GF rada code";
                            IF EmpOrg."Org Entity Code" = 'FBIH'
                              THEN
                                EmpOrg."Contribution Category Code" := 'FBIH';
                            IF ((EmpOrg."Org Entity Code" = 'RS'))
                             THEN
                                EmpOrg."Contribution Category Code" := 'RS';
                            /* IF EmpOrg."Org Entity Code"='BD'
                             THEN EmpOrg."Contribution Category Code":='BDPIOFBIH';*/
                            IF Active = TRUE THEN begin
                                EmpOrg.validate("Benefit Coefficient", EmpOrg."Benefit Coefficient");
                                EmpOrg.MODIFY;
                            end;
                        END;
                    END;
                END
                ELSE BEGIN
                    "Regionalni Head Office" := 0;
                    "Phisical Department Desc" := '';
                    "GF of work Description" := '';
                    "GF rada code" := '';
                    "Org Dio" := '';

                    EmpOrg.SETFILTER("No.", '%1', "Employee No.");
                    IF EmpOrg.FIND('-') THEN BEGIN
                        EmpOrg."Org Municipality" := '';
                        EmpOrg."Municipality Code for salary" := '';
                        EmpOrg."Org Entity Code" := '';
                        EmpOrg.Region := 0;
                        EmpOrg."Org Jed" := '';
                        EmpOrg.GF := '';
                        IF OrgDijelovi."Entity Code" = ''
                      THEN
                            EmpOrg."Contribution Category Code" := '';
                        IF Active = TRUE THEN
                            EmpOrg.MODIFY;
                    END;
                END;

            end;
        }
        field(50391; Email; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Company E-Mail" WHERE("No." = FIELD("Employee No.")));

        }
        field(50392; "Order By"; Integer)
        {
        }
        field(50393; "BJF/GJF"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Position Menu"."BJF/GJF" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                "Code" = FIELD("Position Code"),
                                                                Description = FIELD("Position Description"),
                                                                "Department Code" = FIELD("Department Code")));
            Caption = 'BJF/GJF';

            OptionCaption = ' ,BJF,GJF';
            OptionMembers = " ",BJF,GJF;
        }
        field(50394; "Manager 1 Position ID"; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."Position ID" WHERE("Employee No." = FIELD("Manager 1"),
                                                               "Org. Structure" = FIELD("Org. Structure")));
            Caption = 'Manager 1 Position ID';

        }
        field(50395; "Attachment No."; Integer)
        {
        }
        field(50396; "Sent Mail Employment"; Boolean)
        {
        }
        field(50397; "Sent Mail Termination"; Boolean)
        {
            Caption = 'Sent Mail Termination';
        }
        field(50399; "Sent Mail Duration"; Boolean)
        {
            Caption = 'Sent Mail Duration';
        }
        field(50400; "Sent Mail Change Pos"; Boolean)
        {
            Caption = 'Sent Mail Change Pos';
        }
        field(50401; "Comment for contract"; Text[150])
        {
        }
        field(50402; "Other Attachment No."; Integer)
        {
        }
        field(50403; "Certifications and solutions C"; Code[10])
        {
            Caption = 'Certifications and Solutions Code';
        }
        field(50404; "Cert and solu name"; Text[90])
        {
            Caption = 'Certifications and Solutions';
            TableRelation = "Other Document Register"."Document Description" WHERE("Show Template" = FILTER(true));

            trigger OnValidate()
            begin
                OtheDocumentRegister.RESET;
                OtheDocumentRegister.SETFILTER("Document Description", '%1', "Cert and solu name");
                IF OtheDocumentRegister.FINDFIRST THEN BEGIN
                    "Certifications and solutions C" := OtheDocumentRegister."Agreement Code";
                END
                ELSE BEGIN
                    "Certifications and solutions C" := '';
                END;

                /*CLEAR(Contract88);
                CLEAR(Contract87);
                CLEAR(Contract115);
                CLEAR(Contract129);
                CLEAR(Contract187);
                CLEAR(Contract188);
                CLEAR(Contract189);
                CLEAR(Contract190);
                CLEAR(Contract191);
                CLEAR(Contract192);
                CLEAR(Contract193);
                CLEAR(Contract215);
                CLEAR(Contract216);
                CLEAR(Contract291);
                CLEAR(Contract292);
                CLEAR(Contract296);
                CLEAR(Contract297);
                CLEAR(Contract298);
                CLEAR(Contract319);
                CLEAR(Contract322);
                CLEAR(Contract324);
                CLEAR(Contract406);
                CLEAR(Contract407);
                CLEAR(Contract408);
                CLEAR(Contract410);
                CLEAR(Contract412);
                CLEAR(Contract415);
                CLEAR(Contract416);
                CLEAR(Contract417);
                CLEAR(Contract418);
                CLEAR(Contract491);
                CLEAR(Contract496);
                CLEAR(Contract497);
                CLEAR(Contract498);
                CLEAR(Contract499);
                CLEAR(Contract5057);
                CLEAR(Contract5058);
                CLEAR(Contract5059);
                CLEAR(Contract5060);*/
                ODR.RESET;
                ODR.SETFILTER("Agreement Code", '%1', Rec."Certifications and solutions C");
                ODR.SETFILTER("Show Template", '%1', TRUE);
                IF ODR.FINDLAST THEN BEGIN
                    CRL.SETFILTER("Report ID", '%1', ODR."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        ECL.RESET;
                        ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        IF Rec."Certifications and solutions C" = '88' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract88.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract88.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;


                        IF Rec."Certifications and solutions C" = '87' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract87.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract87.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '115' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract115.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract115.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '129' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract129.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract129.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '187' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract187.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract187.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '188' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract188.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract188.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '189' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract189.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract189.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '190' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract190.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract190.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '190' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract190.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract190.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '191' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract191.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract191.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '192' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract192.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract192.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '193' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract193.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract193.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '215' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract215.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract215.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '216' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK Contract216.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract216.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '291' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK  Contract291.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK Contract291.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '292' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK  Contract292.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract292.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;
                        IF Rec."Certifications and solutions C" = '296' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK  Contract296.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK  Contract296.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '297' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract297.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract297.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;


                        IF Rec."Certifications and solutions C" = '298' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract298.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract298.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;



                        IF Rec."Certifications and solutions C" = '319' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract319.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract319.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '322' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract322.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract322.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;


                        IF Rec."Certifications and solutions C" = '324' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract324.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract324.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '406' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract406.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract406.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '407' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract407.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract407.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;


                        IF Rec."Certifications and solutions C" = '408' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract408.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract408.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;


                        IF Rec."Certifications and solutions C" = '410' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract410.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract410.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '412' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract412.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK    Contract412.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '415' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract415.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract415.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '416' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract416.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract416.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '417' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract417.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract417.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '418' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract418.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract418.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '491' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract491.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract491.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;


                        IF Rec."Certifications and solutions C" = '496' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract496.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract496.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '497' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract497.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract497.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '498' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract498.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract498.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '499' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract499.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract499.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '5057' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract5057.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract5057.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;
                        IF Rec."Certifications and solutions C" = '5058' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract5058.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK    Contract5058.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '5059' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract5059.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract5059.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;

                        IF Rec."Certifications and solutions C" = '5060' THEN BEGIN
                            BrojUgovora := 0;
                            EclCheck.RESET;
                            EclCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF EclCheck.FIND('-') THEN BEGIN
                                BrojUgovora := EclCheck.COUNT;
                            END;
                            //ĐK     Contract5060.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;
                            tempSaveDest := HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx';
                            //ĐK     Contract5060.SAVEASWORD(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            IF "Other Attachment No." <> 0 THEN BEGIN
                                IF NOT CONFIRM(Text004, FALSE) THEN
                                    EXIT;
                                RemoveAttachment1(FALSE);
                                "Other Attachment No." := 0;
                                MODIFY(FALSE);
                                COMMIT;
                            END;
                            NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
                            IF NewOtherAttachNo <> 0 THEN BEGIN
                                "Other Attachment No." := NewOtherAttachNo;
                                COMMIT;
                            END;
                            ImportAttachment1;
                        END;
                        ////
                    END;


                END;
            end;
        }
        field(50405; Change; Boolean)
        {
            Caption = 'Change';
        }
        field(50406; "Number of certification"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Certifications r" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Number of certification and solutions';

        }
        field(50407; "Change other documents"; Boolean)
        {
            Caption = 'Change';
        }
        field(50408; "Org Modification Date"; Date)
        {
        }
        field(50409; "Number of protocol for documen"; Text[30])
        {
            Caption = 'Number of protocols for all documents';
        }
        field(50410; "Number for Contract"; Integer)
        {
            Caption = 'Number for Contract';
        }
        field(50413; "Temporary disposition starting"; Date)
        {
            Caption = 'Temporary disposition starting';

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN BEGIN
                    "Order By" := 5;
                    /*IF "Position Description"='VD*' THEN
                    "Order By":=1;*/
                    IF STRPOS("Position Description", 'VD') <> 0 THEN
                        "Order By" := 1;
                    IF ("Additional Benefits") AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 2;
                    IF ("Temporary disposition" = TRUE) AND ("Additional Benefits" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 3;
                    IF (("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI')) AND ("Additional Benefits" = FALSE) AND ("Temporary disposition" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 4
                END;

            end;
        }
        field(50414; "Temporary disposition ending"; Date)
        {
            Caption = 'Temporary disposition ending';

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN BEGIN
                    "Order By" := 5;
                    /*IF "Position Description"='VD*' THEN
                    "Order By":=1;*/
                    IF STRPOS("Position Description", 'VD') <> 0 THEN
                        "Order By" := 1;
                    IF ("Additional Benefits") AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 2;
                    IF ("Temporary disposition" = TRUE) AND ("Additional Benefits" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 3;
                    IF (("Engagement Type" = 'ODREĐENO') OR ("Engagement Type" = 'ODREĐENO PROBNI')) AND ("Additional Benefits" = FALSE) AND ("Temporary disposition" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                        "Order By" := 4
                END;

            end;
        }
        field(504015; "Show Record"; Boolean)
        {
            Caption = 'Show Record';
        }
        field(594118; "Org Belongs"; Text[130])
        {
            Caption = 'Org Belongs';
            Editable = true;
            TableRelation = Department.Description WHERE("ORG Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                /*IF "Org Belongs"<>'' THEN BEGIN
                      DepartmentTempReal.RESET;
                      DepartmentTempReal.SETFILTER(Description,'%1',"Org Belongs");
                      IF DepartmentTempReal.FINDFIRST THEN BEGIN
                      Sector:=DepartmentTempReal.Sector;
                      "Sector Description":=DepartmentTempReal."Sector  Description";
                      "Department Category":=DepartmentTempReal."Department Category";
                      "Department Cat. Description":=DepartmentTempReal."Department Categ.  Description";
                       Group:=DepartmentTempReal."Group Code";
                      "Group Description":=DepartmentTempReal."Group Description";
                      Team:=DepartmentTempReal."Team Code";
                      "Team Description":=DepartmentTempReal."Team Description";
                      END;
                         END;
                         IF "Position Description"<>'' THEN BEGIN
                DimensiontempForPos.RESET;
                           DimensiontempForPos.SETFILTER("Sector  Description",'%1',"Sector Description");
                           DimensiontempForPos.SETFILTER("Department Categ.  Description",'%1',"Department Cat. Description");
                           DimensiontempForPos.SETFILTER("Group Description",'%1',"Group Description");
                           DimensiontempForPos.SETFILTER("Team Description",'%1',"Team Description");
                           DimensiontempForPos.SETFILTER("Position Description",'%1',"Position Description");
                           IF DimensiontempForPos.FINDFIRST THEN BEGIN
                           "Dimension  Name":=DimensiontempForPos."Dimension  Name";
                           "Dimension Value Code":=DimensiontempForPos."Dimension Value Code";
                           END;
                            END;
                
                        */

            end;
        }
        field(594119; "Engagement Type"; Text[100])
        {
            Caption = 'Engagement Type ';
            TableRelation = "Engagement Type".Description;
        }
        field(594120; "The Change is update"; Boolean)
        {
            Caption = 'The Change is update';
        }
        field(594121; Conflict; Boolean)
        {
            Caption = 'Conflict';
        }
        field(594122; "Modify the change is update"; Boolean)
        {
        }
        field(594123; "Pay Grade"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."PAy grade" WHERE("Code" = FIELD("Position Code"),
                                                             "Position ID" = FIELD("Position ID"),
                                                             "Org. Structure" = FIELD("Org. Structure")));
            Caption = 'Pay Grade';

        }
        field(594124; "Is not extended"; Boolean)
        {
            Caption = 'Is not extended';
        }
        field(594125; "Is not extended expired"; Boolean)
        {
            Caption = 'Is not extended expired';
        }
        field(594126; "Is not extended P"; Boolean)
        {
            Caption = 'Is not extended P';
        }
        field(594127; "Is not extended expired P"; Boolean)
        {
            Caption = 'Is not extended expired P';
        }
        field(594128; "Three Years in company"; Boolean)
        {
            Caption = 'Three Years in company';
        }
        field(594129; "Org Municipality of ag"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi"."Municipality Code" WHERE(Code = FIELD("Org Dio"),
                                                                           GF = FIELD("GF rada code")));
            Caption = 'Municipality';
            Editable = false;

        }
        field(594130; "Rad u smjenama"; Boolean)
        {
            Caption = 'Rad u smjenama';
        }
        field(594131; "Superior1"; Text[100])
        {
            Caption = 'Superior 1';
        }
        field(594132; "Superior2"; Text[100])
        {
            Caption = 'Superior 2';
        }
    }

    keys
    {
        key(Key1; "No.", "Employee No.", "Org. Structure")
        {
        }
        key(Key2; "Starting Date")
        {
        }
        key(Key3; "Department Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ECL.RESET;
        ECL.SETFILTER("Reason for Change", '%1', 2);
        ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");
        ECL.SETFILTER("Show Record", '%1', TRUE);
        ECL.SETFILTER("No.", '<>%1', Rec."No.");
        ECL.SETCURRENTKEY("Starting Date");
        ECL.ASCENDING;
        IF ECL.FINDLAST THEN BEGIN
            Emp.RESET;
            Emp.SETFILTER("No.", '%1', ECL."Employee No.");
            IF Emp.FINDFIRST THEN BEGIN
                Emp."Employment Date" := ECL."Starting Date";
                Emp.MODIFY;
            END;
        END;

        WbDel.SETFILTER("Employee No.", '%1', Rec."Employee No.");
        WbDel.SETFILTER("Contract Ledger Entry No.", '%1', Rec."No.");

        IF WbDel.FINDLAST THEN BEGIN
            WbDel.DELETE;
            R_BroughtExperience.SetEmp("Employee No.");
            R_BroughtExperience.RUN;
            R_WorkExperience2.SetEmp("Employee No.", TODAY);
            R_WorkExperience2.RUN;

        END;
        ECL.RESET;
        ECL.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
        ECL.SETFILTER("Department Code", '%1', Rec."Department Code");
        ECL.SETFILTER("Position Description", '%1', Rec."Position Description");
        ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");
        ECL.SETFILTER("No.", '<>%1', Rec."No.");
        ECL.SETFILTER("Show Record", '%1', TRUE);
        IF ECL.FINDFIRST THEN BEGIN
        END
        ELSE BEGIN
            Pozicije.RESET;
            Pozicije.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
            Pozicije.SETFILTER("Department Code", '%1', Rec."Department Code");
            Pozicije.SETFILTER("Employee No.", '%1', Rec."Employee No.");
            Pozicije.SETFILTER(Description, '%1', Rec."Position Description");
            Pozicije.SETFILTER(Code, '%1', Rec."Position Code");
            IF Pozicije.FINDFIRST THEN
                Pozicije.DELETE;
        END;

        IF Rec."Grounds for Term. Description" <> '' THEN BEGIN
            ECL.RESET;
            ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");
            ECL.SETFILTER("Starting Date", '<%1', Rec."Starting Date");
            ECL.SETFILTER("Show Record", '%1', TRUE);
            ECL.SETFILTER("No.", '<>%1', Rec."No.");
            ECL.SETCURRENTKEY("Starting Date");
            ECL.ASCENDING;
            IF ECL.FINDLAST THEN BEGIN
                WPConnSetup.FINDFIRST();


                /*  CREATE(conn, TRUE, TRUE);

                  conn.Open('PROVIDER=' + WPConnSetup.Provider + ';SERVER=' + WPConnSetup.Server + ';DATABASE=' + WPConnSetup.Database + ';UID=' + WPConnSetup.UID
                            + ';PWD=' + WPConnSetup.Password + ';AllowNtlm=' + FORMAT(WPConnSetup.AllowNtlm));

                  CREATE(comm, TRUE, TRUE);

                  lvarActiveConnection := conn;
                  comm.ActiveConnection := lvarActiveConnection;

                  comm.CommandText := 'dbo.User_TerminationDate';
                  comm.CommandType := 4;
                  comm.CommandTimeout := 0;


                  param := comm.CreateParameter('@EmployeeNo', 200, 1, 30, ECL."Employee No.");
                  comm.Parameters.Append(param);

                  param := comm.CreateParameter('@Termination_date', 7, 1, 0, ECL."Ending Date");
                  comm.Parameters.Append(param);



                  comm.Execute;
                  conn.Close;
                  CLEAR(conn);
                  CLEAR(comm);*/
            END
            ELSE BEGIN

                WPConnSetup.FINDFIRST();


                /* CREATE(conn, TRUE, TRUE);

                 conn.Open('PROVIDER=' + WPConnSetup.Provider + ';SERVER=' + WPConnSetup.Server + ';DATABASE=' + WPConnSetup.Database + ';UID=' + WPConnSetup.UID
                           + ';PWD=' + WPConnSetup.Password + ';AllowNtlm=' + FORMAT(WPConnSetup.AllowNtlm));

                 CREATE(comm, TRUE, TRUE);

                 lvarActiveConnection := conn;
                 comm.ActiveConnection := lvarActiveConnection;

                 comm.CommandText := 'dbo.User_TerminationDate';
                 comm.CommandType := 4;
                 comm.CommandTimeout := 0;


                 param := comm.CreateParameter('@EmployeeNo', 200, 1, 30, "Employee No.");
                 comm.Parameters.Append(param);

                 param := comm.CreateParameter('@Termination_date', 7, 1, 0, 0D);
                 comm.Parameters.Append(param);



                 comm.Execute;
                 conn.Close;
                 CLEAR(conn);
                 CLEAR(comm);*/

            END;
        END
        ELSE BEGIN
            /* WPConnSetup.FINDFIRST();


             CREATE(conn, TRUE, TRUE);

             conn.Open('PROVIDER=' + WPConnSetup.Provider + ';SERVER=' + WPConnSetup.Server + ';DATABASE=' + WPConnSetup.Database + ';UID=' + WPConnSetup.UID
                       + ';PWD=' + WPConnSetup.Password + ';AllowNtlm=' + FORMAT(WPConnSetup.AllowNtlm));

             CREATE(comm, TRUE, TRUE);

             lvarActiveConnection := conn;
             comm.ActiveConnection := lvarActiveConnection;

             comm.CommandText := 'dbo.User_TerminationDate';
             comm.CommandType := 4;
             comm.CommandTimeout := 0;


             param := comm.CreateParameter('@EmployeeNo', 200, 1, 30, "Employee No.");
             comm.Parameters.Append(param);

             param := comm.CreateParameter('@Termination_date', 7, 1, 0, 0D);
             comm.Parameters.Append(param);



             comm.Execute;
             conn.Close;
             CLEAR(conn);
             CLEAR(comm);*/
        END;
        PersonalTrack.RESET;
        PersonalTrack.SETFILTER("Employee No.", '%1', "Employee No.");
        PersonalTrack.SETFILTER("Date of change", '%1', TODAY);
        PersonalTrack.SETFILTER("Employee Contract o.", '%1', FORMAT(Rec."No."));
        PersonalTrack.SETFILTER("Position Name", '%1', Rec."Position Description");
        PersonalTrack.SETFILTER("Starting Date Contract", '%1', Rec."Starting Date");
        IF PersonalTrack.FINDFIRST THEN
            PersonalTrack.DELETE;
    end;

    trigger OnInsert()
    begin
        IF "Employee No." <> '' THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER("No.", "Employee No.");
            IF Employee.FINDFIRST THEN
                "Employee Name" := Employee."First Name" + ' ' + Employee."Last Name";
            "Operator No." := Employee."New Number";
            "Internal ID" := Employee."Internal ID";
        END;
        IF "Employee No." = '' THEN ERROR(Text002);
        EmployeeContractLedger1.RESET;
        EmployeeContractLedger1.SETFILTER("Employee No.", "Employee No.");
        IF EmployeeContractLedger1.FINDFIRST THEN BEGIN
            REPEAT
                // EmployeeContractLedger1.Active:=FALSE;
                //  EmployeeContractLedger1.Status:=1;
                IF (EmployeeContractLedger1."Testing Period Successful" = EmployeeContractLedger1."Testing Period Successful"::" ") AND (EmployeeContractLedger1."Testing Period Ending Date" = CALCDATE('<-1D>', TODAY)) THEN BEGIN
                    EmployeeContractLedger1."Testing Period Successful" := EmployeeContractLedger1."Testing Period Successful"::Yes;
                END;
                EmployeeContractLedger1.MODIFY;
            UNTIL EmployeeContractLedger1.NEXT = 0;
        END;

        IF "Employee No." <> '' THEN BEGIN
            "Order By" := 5;
            /*IF "Position Description"='VD*' THEN
            "Order By":=1;*/
            IF STRPOS("Position Description", 'VD') <> 0 THEN
                "Order By" := 1;
            IF ("Additional Benefits") AND (STRPOS("Position Description", 'VD') = 0) THEN
                "Order By" := 2;
            IF ("Temporary disposition" = TRUE) AND ("Additional Benefits" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                "Order By" := 3;
            IF (("Contract Type" = '-1') OR ("Contract Type" = '4') OR ("Contract Type" = '5')) AND ("Additional Benefits" = FALSE) AND ("Temporary disposition" = FALSE) AND (STRPOS("Position Description", 'VD') = 0) THEN
                "Order By" := 4
        END;

        //Active:=TRUE;
        Contract := TRUE;
        "Prohibition of Competition" := TRUE;

        EmployeeContractLedger1.RESET;
        EmployeeContractLedger1.SETFILTER("Employee No.", "Employee No.");
        IF EmployeeContractLedger1.FINDLAST THEN BEGIN
            Rec."First Time Employed" := xRec."First Time Employed";
        END
        ELSE BEGIN
            "First Time Employed" := TRUE;
        END;





        ORGShema.RESET;
        ORGShema.SETFILTER(Status, '%1', ORGShema.Status::Active);
        IF ORGShema.FINDLAST THEN BEGIN
            "Org. Structure" := ORGShema.Code;
        END
        ELSE BEGIN
            "Org. Structure" := '';
        END;
        "Show Record" := TRUE;


        IF "Employee No." <> '' THEN
            EVALUATE(Order, "Employee No.");
        "Registration Date" := "Starting Date";

        "Number for Contract" := 1;

        Description := '';

    end;

    trigger OnModify()
    begin

        Izmjena := FALSE;
        "Registration Date" := "Starting Date";

        IF ((USERID <> 'MBDOM\HRAPP') AND (USERID <> 'MBDOM\FEDJA.BOGDANOVIC')) THEN
            "Operator No." := USERID;
        IF (xRec."Starting Date" <> Rec."Starting Date") THEN
            // AND (Rec."Reason for Change"=Rec."Reason for Change"::"New Contract")) THEN
            VALIDATE("Starting Date", Rec."Starting Date");
        IF xRec."Team Description" <> Rec."Team Description" THEN BEGIN
            VALIDATE("Team Description", Rec."Team Description");
            Izmjena := TRUE;
        END;
        IF xRec."Group Description" <> Rec."Group Description" THEN BEGIN
            VALIDATE("Group Description", Rec."Group Description");
            Izmjena := TRUE;
        END;
        IF xRec."Department Cat. Description" <> Rec."Department Cat. Description" THEN BEGIN
            VALIDATE("Department Cat. Description", Rec."Department Cat. Description");
            Izmjena := TRUE;
        END;

        IF xRec."Sector Description" <> Rec."Sector Description" THEN BEGIN
            VALIDATE("Sector Description", Rec."Sector Description");
            Izmjena := TRUE;
        END;

        IF (xRec."Position Description" = Rec."Position Description") AND (Izmjena = TRUE) THEN
            VALIDATE("Position Description", Rec."Position Description");

        position.RESET;
        position.SETFILTER("Employee No.", '%1', "Employee No.");
        position.SETFILTER(Code, '%1', "Position Code");
        position.SETFILTER(Description, '%1', "Position Description");
        position.SETFILTER("Department Code", '%1', "Department Code");
        position.SETFILTER("Org. Structure", '%1', "Org. Structure");
        IF position.FINDFIRST THEN BEGIN
            IF position."Position ID" <> Rec."Position ID" THEN
                Rec."Position ID" := position."Position ID";
            Rec.MODIFY;
        END;

        IF Active = TRUE THEN BEGIN
            /*BEGIN
            WPConnSetup.FINDFIRST();
              EmployeeContractLedger2.RESET;
            CLEAR(EmployeeContractLedger2."Manager 1");
            CLEAR(EmployeeContractLedger2."Manager 2");
            CLEAR(EmployeeContractLedger3."Manager 1");
            CLEAR(EmployeeContractLedger3."Manager 2");
            CLEAR(EmployeeContractLedger4."Manager 1");
            CLEAR(EmployeeContractLedger4."Manager 2");
            CLEAR(EmployeeContractLedger5."Manager 1");
            CLEAR(EmployeeContractLedger5."Manager 2");
            CLEAR(EmployeeContractLedger6."Manager 1");
            CLEAR(EmployeeContractLedger6."Manager 2");
            CLEAR(EmployeeContractLedger7."Manager 1");
            CLEAR(EmployeeContractLedger7."Manager 2");

                           CREATE(conn, TRUE, TRUE);


                           conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                                     +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));

                           CREATE(comm,TRUE, TRUE);

                           lvarActiveConnection := conn;
                           comm.ActiveConnection := lvarActiveConnection;

                           comm.CommandText := 'dbo.PositionCode_Update';
                           comm.CommandType := 4;
                           comm.CommandTimeout := 0;

                           param:=comm.CreateParameter('@EmployeeNo', 200, 1, 30, "Employee No.");
                           comm.Parameters.Append(param);
                           CALCFIELDS("Manager 1");

                             param:=comm.CreateParameter('@managment_level', 200, 1, 30, "Management Level");
                           comm.Parameters.Append(param);

                             param:=comm.CreateParameter('@position_code', 200, 1, 30, "Position Code");
                           comm.Parameters.Append(param);

                              param:=comm.CreateParameter('@position', 200, 1, 250  , "Position Description");
                           comm.Parameters.Append(param);

                           param:=comm.CreateParameter('@stream_parent', 200, 1, 30, '');
                           comm.Parameters.Append(param);

                           CALCFIELDS("Manager 1","Manager 1 Position Code","Manager Department Code","Manager 2");
                           CALCFIELDS("Manager 1 First Name","Manager 1 Last Name");




                      IF "Manager 1"<>'' THEN
                       param:=comm.CreateParameter('@parent', 200, 1, 30,"Manager 1")
                      ELSE
                       param:=comm.CreateParameter('@parent', 200, 1, 30,"Manager 2");
                      comm.Parameters.Append(param);



                      IF "Manager 1"<>'' THEN
                      param:=comm.CreateParameter('@ParentMBO2', 200, 1, 30,"Manager 2")
                      ELSE
                        param:=comm.CreateParameter('@ParentMBO2', 200, 1, 30,0);
                      comm.Parameters.Append(param);


                                              EmployeeContractLedger3.RESET;
                                              IF EmployeeContractLedger2."Manager 2"<>'' THEN BEGIN
                                              EmployeeContractLedger3.RESET;
                                              EmployeeContractLedger3.SETFILTER("Employee No.",EmployeeContractLedger2."Manager 2");
                                              EmployeeContractLedger3.SETFILTER(Active,'%1',TRUE);
                                              IF EmployeeContractLedger3.FINDLAST THEN BEGIN
                                                 EmployeeContractLedger3.CALCFIELDS("Manager 1","Manager 1 Position Code","Manager Department Code","Manager 2");
                      EmployeeContractLedger3.CALCFIELDS("Manager 1 First Name","Manager 1 Last Name");
                                                              param:=comm.CreateParameter('@ParentMBO3', 200, 1, 30,EmployeeContractLedger3."Manager 1");
                                                             comm.Parameters.Append(param);
                                                              param:=comm.CreateParameter('@ParentMBO4', 200, 1, 30,EmployeeContractLedger3."Manager 2");
                                                             comm.Parameters.Append(param);
                                              END
                                              END
                                              ELSE BEGIN
                                                 param:=comm.CreateParameter('@ParentMBO3', 200, 1, 30,0);
                                                             comm.Parameters.Append(param);
                                                       param:=comm.CreateParameter('@ParentMBO4', 200, 1, 30,0);
                                                             comm.Parameters.Append(param);

                                              END;

                                              EmployeeContractLedger4.RESET;
                                              IF EmployeeContractLedger3."Manager 2"<>'' THEN BEGIN
                                              EmployeeContractLedger4.RESET;
                                              EmployeeContractLedger4.SETFILTER("Employee No.",EmployeeContractLedger3."Manager 2");
                                              EmployeeContractLedger4.SETFILTER(Active,'%1',TRUE);
                                              IF EmployeeContractLedger4.FINDLAST THEN BEGIN
                                              EmployeeContractLedger4.CALCFIELDS("Manager 1","Manager 1 Position Code","Manager Department Code","Manager 2");
                                                 EmployeeContractLedger4.CALCFIELDS("Manager 1 First Name","Manager 1 Last Name");
                                                             param:=comm.CreateParameter('@ParentMBO5', 200, 1, 30,EmployeeContractLedger4."Manager 1");
                                                             comm.Parameters.Append(param);
                                                              param:=comm.CreateParameter('@ParentMBO6', 200, 1, 30,EmployeeContractLedger4."Manager 2");
                                                             comm.Parameters.Append(param);
                                              END
                                              END
                                              ELSE BEGIN
                                                 param:=comm.CreateParameter('@ParentMBO5', 200, 1, 30,0);
                                                             comm.Parameters.Append(param);
                                                                  param:=comm.CreateParameter('@ParentMBO6', 200, 1, 30,0);
                                                             comm.Parameters.Append(param);

                                              END;

                            comm.Execute;
                            conn.Close;
                            CLEAR(conn);
                            CLEAR(comm);
             END;





            BEGIN
            WPConnSetup.FINDFIRST();

                           CREATE(conn, TRUE, TRUE);


                          conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                                     +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));

                           CREATE(comm,TRUE, TRUE);

                           lvarActiveConnection := conn;
                           comm.ActiveConnection := lvarActiveConnection;

                           comm.CommandText := 'dbo.DepatmentCode_Update';
                           comm.CommandType := 4;
                           comm.CommandTimeout := 0;


                            param:=comm.CreateParameter('@EmployeeNo', 200, 1, 30, "Employee No.");
                           comm.Parameters.Append(param);

                           param:=comm.CreateParameter('@Parent2', 200, 1, 30, parent2);
                           comm.Parameters.Append(param);
                           param:=comm.CreateParameter('@Parent3', 200, 1, 30,parent3);
                           comm.Parameters.Append(param);

                          param:=comm.CreateParameter('@b1_desc', 200, 1, 250, "Sector Description");
                          comm.Parameters.Append(param);

                          param:=comm.CreateParameter('@b1_reg', 200, 1,250, "Department Category");
                          comm.Parameters.Append(param);

                          param:=comm.CreateParameter('@b1_reg_desc', 200, 1, 250, "Department Cat. Description");
                          comm.Parameters.Append(param);

                          param:=comm.CreateParameter('@stream_desc', 200, 1, 250, "Group Description");
                          comm.Parameters.Append(param);


                           param:=comm.CreateParameter('@DepartmentCode', 200, 1, 250, "Department Category");
                           comm.Parameters.Append(param);


                           param:=comm.CreateParameter('@Sector', 200, 1, 250,Sector);
                           comm.Parameters.Append(param);


                           param:=comm.CreateParameter('@stream_code', 200, 1, 250,Group);
                           comm.Parameters.Append(param);



                           param:=comm.CreateParameter('@Team', 200, 1, 250,Team);
                           comm.Parameters.Append(param);

                           param:=comm.CreateParameter('@Team_description', 200, 1, 250,"Team Description");
                           comm.Parameters.Append(param);

                           Wagesetup.GET;
                           emphours.SETFILTER("No.",'%1',"Employee No.");
                           IF emphours.FINDFIRST
                             THEN
                             param:=comm.CreateParameter('@br_sati', 3, 1, 0,emphours."Hours In Day")
                             ELSE
                           param:=comm.CreateParameter('@br_sati', 3, 1, 0,Wagesetup."Hours in Day");
                          comm.Parameters.Append(param);
                          CALCFIELDS("Department Address","Department City");
                           param:=comm.CreateParameter('@mjesto_org', 200, 1, 250,"Department City");
                           comm.Parameters.Append(param);

                           param:=comm.CreateParameter('@mjesto_rada', 200, 1, 250,"Phisical Department Desc");
                           comm.Parameters.Append(param);


                            param:=comm.CreateParameter('@address_org', 200, 1, 250,"Department Address");
                           comm.Parameters.Append(param);
                            comm.Execute;
                            conn.Close;
                            CLEAR(conn);
                            CLEAR(comm);*/

            BEGIN


                /*  WPConnSetup.FINDFIRST();
                  ConnectionString := 'Server=' + WPConnSetup.Server + ';'
                  + 'Database=' + WPConnSetup.Database + ';'
                  + 'Uid=' + WPConnSetup.UID + ';'
                  + 'Pwd=' + WPConnSetup.Password + ';';
                  SQLConn := SQLConn.SqlConnection(ConnectionString);
                  SQLConn.Open;

                  SQLCommand := SQLCommand.SqlCommand();

                  SQLCommand.CommandText := 'dbo.PositionCode_Update';
                  SQLCommand.Connection := SQLConn;
                  SQLCommand.CommandType := 4;
                  SQLCommand.CommandTimeout := 0;

                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@EmployeeNo';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Employee No.";
                  SQLCommand.Parameters.Add(SQLParameter);

                  CALCFIELDS("Manager 1");
                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@ManagementLevel';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Management Level";
                  SQLCommand.Parameters.Add(SQLParameter);


                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@PositionCode';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Position Code";
                  SQLCommand.Parameters.Add(SQLParameter);


                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@position';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Position Description";
                  SQLCommand.Parameters.Add(SQLParameter);

                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@stream_parent';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := '';
                  SQLCommand.Parameters.Add(SQLParameter);


                  CALCFIELDS("Manager 1", "Manager 1 Position Code", "Manager Department Code", "Manager 2");
                  CALCFIELDS("Manager 1 First Name", "Manager 1 Last Name");


                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@parent';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;


                  IF "Manager 1" <> '' THEN
                      //param:=comm.CreateParameter('@parent', 200, 1, 30,"Manager 1")
                      SQLParameter.Value := "Manager 1"
                  ELSE
                      //param:=comm.CreateParameter('@parent', 200, 1, 30,"Manager 2");
                      SQLParameter.Value := "Manager 2";
                  //comm.Parameters.Append(param);
                  SQLCommand.Parameters.Add(SQLParameter);

                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@ParentMBO2';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  IF "Manager 1" <> '' THEN
                      // param:=comm.CreateParameter('@ParentMBO2', 200, 1, 30,"Manager 2")
                      SQLParameter.Value := "Manager 2"
                  ELSE
                      //    param:=comm.CreateParameter('@ParentMBO2', 200, 1, 30,0);
                      SQLParameter.Value := 0;
                  //comm.Parameters.Append(param);
                  SQLCommand.Parameters.Add(SQLParameter);


                  EmployeeContractLedger3.RESET;
                  IF EmployeeContractLedger2."Manager 2" <> '' THEN BEGIN
                      EmployeeContractLedger3.RESET;
                      EmployeeContractLedger3.SETFILTER("Employee No.", EmployeeContractLedger2."Manager 2");
                      EmployeeContractLedger3.SETFILTER(Active, '%1', TRUE);
                      IF EmployeeContractLedger3.FINDLAST THEN BEGIN
                          EmployeeContractLedger3.CALCFIELDS("Manager 1", "Manager 1 Position Code", "Manager Department Code", "Manager 2");
                          EmployeeContractLedger3.CALCFIELDS("Manager 1 First Name", "Manager 1 Last Name");

                          SQLParameter := SQLParameter.SqlParameter;
                          SQLParameter.ParameterName := '@ParentMBO3';
                          SQLParameter.DbType := SQLDbType.String;
                          SQLParameter.Direction := SQLParameter.Direction.Input;
                          SQLParameter.Value := EmployeeContractLedger3."Manager 1";
                          SQLCommand.Parameters.Add(SQLParameter);
                          SQLParameter := SQLParameter.SqlParameter;
                          SQLParameter.ParameterName := '@ParentMBO4';
                          SQLParameter.DbType := SQLDbType.String;
                          SQLParameter.Direction := SQLParameter.Direction.Input;
                          SQLParameter.Value := EmployeeContractLedger3."Manager 2";
                          SQLCommand.Parameters.Add(SQLParameter);
                      END
                  END
                  ELSE BEGIN

                      SQLParameter := SQLParameter.SqlParameter;
                      SQLParameter.ParameterName := '@ParentMBO3';
                      SQLParameter.DbType := SQLDbType.String;
                      SQLParameter.Direction := SQLParameter.Direction.Input;
                      SQLParameter.Value := 0;
                      SQLCommand.Parameters.Add(SQLParameter);
                      SQLParameter := SQLParameter.SqlParameter;
                      SQLParameter.ParameterName := '@ParentMBO4';
                      SQLParameter.DbType := SQLDbType.String;
                      SQLParameter.Direction := SQLParameter.Direction.Input;
                      SQLParameter.Value := 0;
                      SQLCommand.Parameters.Add(SQLParameter);

                  END;

                  EmployeeContractLedger4.RESET;
                  IF EmployeeContractLedger3."Manager 2" <> '' THEN BEGIN
                      EmployeeContractLedger4.RESET;
                      EmployeeContractLedger4.SETFILTER("Employee No.", EmployeeContractLedger3."Manager 2");
                      EmployeeContractLedger4.SETFILTER(Active, '%1', TRUE);
                      IF EmployeeContractLedger4.FINDLAST THEN BEGIN
                          EmployeeContractLedger4.CALCFIELDS("Manager 1", "Manager 1 Position Code", "Manager Department Code", "Manager 2");
                          EmployeeContractLedger4.CALCFIELDS("Manager 1 First Name", "Manager 1 Last Name");

                          SQLParameter := SQLParameter.SqlParameter;
                          SQLParameter.ParameterName := '@ParentMBO5';
                          SQLParameter.DbType := SQLDbType.String;
                          SQLParameter.Direction := SQLParameter.Direction.Input;
                          SQLParameter.Value := EmployeeContractLedger4."Manager 1";
                          SQLCommand.Parameters.Add(SQLParameter);
                          SQLParameter := SQLParameter.SqlParameter;
                          SQLParameter.ParameterName := '@ParentMBO6';
                          SQLParameter.DbType := SQLDbType.String;
                          SQLParameter.Direction := SQLParameter.Direction.Input;
                          SQLParameter.Value := EmployeeContractLedger4."Manager 2";
                          SQLCommand.Parameters.Add(SQLParameter);
                      END
                  END
                  ELSE BEGIN

                      SQLParameter := SQLParameter.SqlParameter;
                      SQLParameter.ParameterName := '@ParentMBO5';
                      SQLParameter.DbType := SQLDbType.String;
                      SQLParameter.Direction := SQLParameter.Direction.Input;
                      SQLParameter.Value := 0;
                      SQLCommand.Parameters.Add(SQLParameter);
                      SQLParameter := SQLParameter.SqlParameter;
                      SQLParameter.ParameterName := '@ParentMBO6';
                      SQLParameter.DbType := SQLDbType.String;
                      SQLParameter.Direction := SQLParameter.Direction.Input;
                      SQLParameter.Value := 0;
                      SQLCommand.Parameters.Add(SQLParameter);

                  END;

                  SQLCommand.ExecuteNonQuery;
                  SQLConn.Close;
                  SQLConn.Dispose;
              END;



              BEGIN

                  WPConnSetup.FINDFIRST();
                  ConnectionString := 'Server=' + WPConnSetup.Server + ';'
                  + 'Database=' + WPConnSetup.Database + ';'
                  + 'Uid=' + WPConnSetup.UID + ';'
                  + 'Pwd=' + WPConnSetup.Password + ';';
                  SQLConn := SQLConn.SqlConnection(ConnectionString);
                  SQLConn.Open;

                  SQLCommand := SQLCommand.SqlCommand();

                  SQLCommand.CommandText := 'dbo.DepatmentCode_Update';
                  SQLCommand.Connection := SQLConn;
                  SQLCommand.CommandType := 4;
                  SQLCommand.CommandTimeout := 0;

                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@EmployeeNo';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Employee No.";
                  SQLCommand.Parameters.Add(SQLParameter);




                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@Parent2';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := parent2;
                  SQLCommand.Parameters.Add(SQLParameter);


                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@Parent3';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := parent3;
                  SQLCommand.Parameters.Add(SQLParameter);


                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@b1_desc';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Sector Description";
                  SQLCommand.Parameters.Add(SQLParameter);



                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@b1_reg';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Department Category";
                  SQLCommand.Parameters.Add(SQLParameter);


                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@b1_reg_desc';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Department Cat. Description";
                  SQLCommand.Parameters.Add(SQLParameter);


                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@stream_desc';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Group Description";
                  SQLCommand.Parameters.Add(SQLParameter);


                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@DepartmentCode';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Department Category";
                  SQLCommand.Parameters.Add(SQLParameter);


                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@Sector';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := Sector;
                  SQLCommand.Parameters.Add(SQLParameter);


                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@stream_code';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := Group;
                  SQLCommand.Parameters.Add(SQLParameter);



                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@Team';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := Team;
                  SQLCommand.Parameters.Add(SQLParameter);


                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@Team_description';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Team Description";
                  SQLCommand.Parameters.Add(SQLParameter);

                  Wagesetup.GET;
                  emphours.SETFILTER("No.", '%1', "Employee No.");

                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@br_sati';
                  SQLParameter.DbType := SQLDbType.Int32;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  IF emphours.FINDFIRST
                    THEN
                      // param:=comm.CreateParameter('@br_sati', 3, 1, 0,emphours."Hours In Day")
                      SQLParameter.Value := emphours."Hours In Day"
                  ELSE
                      // param:=comm.CreateParameter('@br_sati', 3, 1, 0,Wagesetup."Hours in Day");
                      SQLParameter.Value := Wagesetup."Hours in Day";
                  // comm.Parameters.Append(param);
                  SQLCommand.Parameters.Add(SQLParameter);

                  CALCFIELDS("Department Address", "Department City");

                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@mjesto_org';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Department City";
                  SQLCommand.Parameters.Add(SQLParameter);

                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@mjesto_rada';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Phisical Department Desc";
                  SQLCommand.Parameters.Add(SQLParameter);

                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@address_org';
                  SQLParameter.DbType := SQLDbType.String;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  SQLParameter.Value := "Department Address";
                  SQLCommand.Parameters.Add(SQLParameter);

                  SQLParameter := SQLParameter.SqlParameter;
                  SQLParameter.ParameterName := '@centrala';
                  SQLParameter.DbType := SQLDbType.Int32;
                  SQLParameter.Direction := SQLParameter.Direction.Input;
                  CALCFIELDS("Residence/Network");
                  IF "Residence/Network" = "Residence/Network"::Residence THEN
                      SQLParameter.Value := 1
                  ELSE
                      SQLParameter.Value := 0;
                  SQLCommand.Parameters.Add(SQLParameter);



                  SQLCommand.ExecuteNonQuery;
                  SQLConn.Close;
                  SQLConn.Dispose;


  */
            END;

        END;

        IF (((xRec."Starting Date" <> Rec."Starting Date") OR (xRec."Ending Date" <> Rec."Ending Date")))
      THEN BEGIN
            WbMod.SETFILTER("Employee No.", '%1', Rec."Employee No.");
            IF (xRec."Starting Date" <> Rec."Starting Date")
            THEN
                WbMod.SETFILTER("Contract Ledger Entry No.", '%1', Rec."No.");

            IF (xRec."Ending Date" <> Rec."Ending Date")
               THEN BEGIN
                ExternalDate.RESET;
                ExternalDate.SETFILTER("Reason for Change", '%1|%2', "Reason for Change"::"New Contract", "Reason for Change"::Migration);
                ExternalDate.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                ExternalDate.SETFILTER("Starting Date", '<=%1', "Starting Date");
                ExternalDate.SETFILTER("Show Record", '%1', TRUE);
                ExternalDate.SETCURRENTKEY("Starting Date");
                ExternalDate.ASCENDING;
                IF ExternalDate.FINDLAST THEN
                    WbMod.SETFILTER("Contract Ledger Entry No.", '%1', ExternalDate."No.");
            END;


            IF WbMod.FINDLAST THEN BEGIN
                IF ((WbMod."Starting Date" <> "Starting Date") AND (xRec."Starting Date" <> Rec."Starting Date") AND
              ((Rec."Reason for Change" = Rec."Reason for Change"::"New Contract") OR (Rec."Reason for Change" = Rec."Reason for Change"::Migration))) THEN
                    WbMod."Starting Date" := "Starting Date";
                IF ((WbMod."Ending Date" <> TODAY) AND (xRec."Ending Date" <> Rec."Ending Date")) THEN BEGIN
                    IF (Rec."Ending Date" = 0D) OR (Rec."Ending Date" > TODAY) THEN
                        WbMod."Ending Date" := TODAY ELSE
                        WbMod."Ending Date" := "Ending Date";
                END;
                HRSetup.GET;
                IF Rec."Engagement Type" <> HRSetup."External Description" THEN
                    WbMod.VALIDATE("Current Company", TRUE);
                WbMod.MODIFY;
                WbMod.VALIDATE("Validate Work Experience", TRUE);
                WbMod.MODIFY;

            END;
            IF Rec."Engagement Type" <> HRSetup."External Description"
            THEN
                R_BroughtExperience.SetEmp("Employee No.")
            ELSE
                R_BroughtExperience.SetStatus("Employee No.", '', 'EXTERNAL');
            R_BroughtExperience.RUN;
            R_WorkExperience2.SetEmp("Employee No.", TODAY);
            R_WorkExperience2.RUN;
        END;


        IF (xRec."Ending Date" <> Rec."Ending Date") OR (Rec."Starting Date" <> xRec."Starting Date") THEN BEGIN
            IF Rec."Reason for Change" = Rec."Reason for Change"::"New Contract" THEN BEGIN
                WbMod.RESET;
                WbMod.SETFILTER("Current Company", '%1', TRUE);
                WbMod.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                WbMod.SETFILTER("Contract Ledger Entry No.", '<>%1', Rec."No.");
                WbMod.SETCURRENTKEY("Starting Date");
                WbMod.ASCENDING;
                IF WbMod.FINDLAST THEN BEGIN
                    ECLRec.RESET;
                    ECLRec.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                    ECLRec.SETFILTER("Starting Date", '<%1', Rec."Starting Date");
                    ECLRec.SETFILTER("Show Record", '%1', TRUE);
                    ECLRec.SETFILTER("Engagement Type", '<>%1', 'MIROVANJE');
                    ECLRec.SETCURRENTKEY("Starting Date");
                    ECLRec.ASCENDING;
                    IF ECLRec.FINDLAST THEN BEGIN
                        WbMod."Ending Date" := ECLRec."Ending Date";
                        WbMod.MODIFY;
                    END;
                END;
            END
            ELSE BEGIN


                ECLRec.RESET;
                ECLRec.SETFILTER("Reason for Change", '%1', ECLRec."Reason for Change"::"New Contract");
                ECLRec.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                ECLRec.SETFILTER("Starting Date", '<>%1', Rec."Starting Date");
                ECLRec.SETCURRENTKEY("Starting Date");
                ECLRec.ASCENDING;
                IF ECLRec.FINDLAST THEN BEGIN
                    WbMod.RESET;
                    WbMod.SETFILTER("Current Company", '%1', TRUE);
                    WbMod.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                    WbMod.SETFILTER("Contract Ledger Entry No.", '<>%1', ECLRec."No.");
                    WbMod.SETCURRENTKEY("Starting Date");
                    WbMod.ASCENDING;
                    IF WbMod.FINDLAST THEN BEGIN
                        ECLRec2.RESET;
                        ECLRec2.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        ECLRec2.SETFILTER("Starting Date", '<%1', ECLRec."Starting Date");
                        ECLRec2.SETFILTER("Show Record", '%1', TRUE);
                        ECLRec2.SETFILTER("Engagement Type", '<>%1', 'MIROVANJE');
                        ECLRec2.SETCURRENTKEY("Starting Date");
                        ECLRec2.ASCENDING;
                        IF ECLRec2.FINDLAST THEN BEGIN
                            WbMod."Ending Date" := ECLRec2."Ending Date";
                            WbMod.MODIFY;
                        END;
                    END;
                END
                ELSE BEGIN
                    ECLRec.RESET;
                    ECLRec.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                    ECLRec.SETCURRENTKEY("Starting Date");
                    ECLRec.SETFILTER("Reason for Change", '<>%1', ECLRec."Reason for Change"::"New Contract");
                    ECLRec.ASCENDING;
                    IF ECLRec.FINDLAST THEN BEGIN
                        ECLRec2.RESET;
                        ECLRec2.SETFILTER("Reason for Change", '%1', ECLRec2."Reason for Change"::"New Contract");
                        ECLRec2.SETFILTER("Employee No.", '%1', ECLRec."Employee No.");
                        ECLRec2.SETCURRENTKEY("Starting Date");
                        ECLRec2.ASCENDING;
                        IF ECLRec2.FINDFIRST THEN BEGIN
                            WbMod.RESET;
                            WbMod.SETFILTER("Contract Ledger Entry No.", '<>%1', ECLRec2."No.");
                            WbMod.SETFILTER("Employee No.", '%1', ECLRec."Employee No.");
                            WbMod.SETFILTER("Current Company", '%1', TRUE);
                            WbMod.SETCURRENTKEY("Starting Date");
                            WbMod.ASCENDING;
                            IF WbMod.FINDLAST THEN BEGIN
                                WbMod."Ending Date" := ECLRec."Ending Date";
                                WbMod.MODIFY;
                            END;
                        END;

                    END;


                END;
            END;
        END;
        IF ((Rec.Brutto <> 0) AND (xRec.Brutto <> Rec.Brutto)) THEN BEGIN
            CALCFIELDS(Rec.Region, Rec."Pay Grade");
            PayRange.SETFILTER("Pay Grade", '%1', Rec."Pay Grade");
            PayRange.SETFILTER(Region, '%1', Rec.Region);
            IF PayRange.FINDFIRST THEN BEGIN
                IF Rec.Brutto < PayRange."Min Region" THEN
                    MESSAGE(BruttoError);
                IF Rec.Brutto > PayRange."Max Region" THEN
                    MESSAGE(BruttoError);
            END;
        END;
        IF ("Starting Date" <> 0D) AND ("Show Record" = TRUE) AND (Rec."No." <> 0) THEN
            Maticna.EmployeeContractLedger2(xRec, Rec);


    end;

    var
        //ĐK SQLConn: DotNet SqlConnection;
        ConnectionString: Text;
        /*SQLCommand: DotNet SqlCommand;
        SQLParameter: DotNet SqlParameter;
        SQLDbType: DotNet DbTypeĐK ;*/
        WbMod2: Record "Work Booklet";
        WbMod: Record "Work Booklet";
        WbDel: Record "Work Booklet";
        StavkeUgovora: Record "Employee Contract Ledger";
        Brojac: Integer;
        ECLBefore2: Record "Employee Contract Ledger";
        AttachmentRecord: Record "Attachment";
        gro: Date;
        ECLRec2: Record "Employee Contract Ledger";
        EngagementType: Record "Engagement Type";
        ECLRec: Record "Employee Contract Ledger";
        ECLCD: Record "Employee Contract Ledger";
        BruttoTotal: Decimal;
        TaxWe: Decimal;
        eclbef: Record "Employee Contract Ledger";
        BruttoAfterDeductionWE: Decimal;
        WBB: Record "Work Booklet";
        BruttoAfterContributionWE: Decimal;
        WageAmounts: Record "Wage Amounts";
        BeforePosition: Text;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        ConCat: Record "Contribution Category";
        BruttoAfterContribution: Decimal;
        BruttoAfterDeduction: Decimal;
        EksterniAngazman: Boolean;
        Employee: Record "Employee";
        WbMod9: Record "Work Booklet";
        CompanyInfo: Record "Company Information";
        TaxR: Record "Dimension temporary";
        Employee1: Record "Employee";
        EmployeeContractLedger1: Record "Employee Contract Ledger";
        Emp: Record "Employee";
        PersonalTrack: Record "Personal track report";
        ECL: Record "Employee Contract Ledger";
        ECLExtern: Record "Employee Contract Ledger";
        PostCode: Record "Post Code";
        GroundsForTermination: Record "Grounds for Termination";
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        position: Record "Position";
        "Position Benef": Record "Position Benefits";
        MAI: Record "Misc. Article Information";
        Text000: Label 'Start Date must have value.';
        Text001: Label 'End Date must not be before Start date.';
        IDMonth: Integer;
        TotalDays: Integer;
        WC: Record "Wage Calculation";
        Department: Record "Department";
        ORG: Record "ORG Dijelovi";
        StartDate: Date;
        EndDate: Date;
        EDF: Record "Employee Default Dimension";
        DV: Record "Dimension Value";
        ORGShema: Record "ORG Shema";
        parent2: Code[30];
        parent3: Code[30];
        WPConnSetup: Record "Web portal connection setup";
        /*  conn: Automation;
          comm: Automation;
          param: Automation;*/
        lvarActiveConnection: Variant;
        Text002: Label 'Personalni broj ne smije biti prazan!';
        WDV: Record "Work Duties Violation";
        WDVM: Record "Work Duties Violation";
        WDVR: Record "Work Duties Violation";
        CM: Record "Comission Members";
        /* SegmentationGroupWDM: Record "Segmentation Data";
         SegmentationGroupWDR: Record "Segmentation Data";
         SegmentationGroupWD: Record "Segmentation Data";
         SegmentationGroupCM: Record "Segmentation Data";*/
        DepartmentW: Record "Department";
        DepartmentM: Record "Department";
        DepartmentR: Record "Department";
        DepartmentCM: Record "Department";
        // SegmentationP: Record "Segmentation Data";
        WPConnSetupPos: Record "Web portal connection setup";
        /* connPos: Automation;
         commPos: Automation;
         paramPos: Automation;
         lvarActiveConnectionPos: Variant;*/
        pos: Record "Position";
        TeamRec: Record "TeamT";
        DepCat: Record "Department Category";
        Sec: Record "Sector";
        Gr: Record "Group";
        DocumentReg: Record "Document Register";
        WorkBook: Record "Work Booklet";
        WorkBook2: Record "Work Booklet";
        R_WorkExperience: Report "Work exp.in Comp.by Emp";
        OrgDijelovi: Record "ORG Dijelovi";
        ID_Month_novi: Integer;
        OneDay: Date;
        MonthDays: Date;
        NewPosition: Record "Position";
        RecDate: Record "Date";
        LastFoundDate: Date;
        TempDate: Date;
        Found: Boolean;
        CountYears: Integer;
        CountMonths: Integer;
        CountDays: Integer;
        RecDate1: Record "Date";
        LastFoundDate1: Date;
        TempDate1: Date;
        Found1: Boolean;
        CountMonths1: Integer;
        CountDays1: Integer;
        MannersForTermination: Record "Manner for Termination";
        EmploymentContract: Record "Employment Contract";
        Empl: Record "Employee";
        CountYears1: Integer;
        EmpOrg: Record "Employee";
        LastDate: Date;
        Feb: Integer;
        LengthCode: Integer;
        PosD: Record "Position";
        ECLProb: Record "Employee Contract Ledger";
        posDis: Record "Position";
        Text003: Label 'You have canceled the create process.';
        Text004: Label 'Replace existing attachment?';
        Text005: Label 'You have canceled the import process.';
        Text006: Label 'Export Attachment';
        Text007: Label 'Da li ste sigurni da zelite promijeniti vrijednost polja iz %1 u %2?';
        Answer: Boolean;
        InteractTmplLanguage: Record "Interaction Tmpl. Language";
        Attachment: Record "Attachment";
        AttachmentManagement: Codeunit "AttachmentManagement";
        NewAttachNo: Integer;
        DR: Record "Document Register";
        ReportLayoutSelection: Record "Report Layout Selection";
        //  ContractR: Report "test";
        DR1: Record "Document Register";
        CRL1: Record "Custom Report Layout";
        OtheDocumentRegister: Record "Other Document Register";
        ODR: Record "Other Document Register";
        NewOtherAttachNo: Integer;
        CRL: Record "Custom Report Layout";
        OtherDocumentRegister: Record "Other Document Register";
        CLR4: Record "Custom Report Layout";
        //  ContractTermination: Report "Agreement of termination -r";
        PosNew: Record "Position";
        ID: Integer;
        ActivePosition: Record "Position";
        ActiveECL: Record "Employee Contract Ledger";
        "Max": Integer;
        PositionDelete: Record "Position";
        ECLNumber: Record "Employee Contract Ledger";
        ECLBefore: Record "Employee Contract Ledger";
        FileManagement: Codeunit "File Management";
        BrojUgovora: Integer;
        EclCheck: Record "Employee Contract Ledger";
        tempSaveDest: Text;
        // Contract1: Report "Anex 29.12.17 Promjena r,o,p";
        /* Contract3: Report "3";
        Contract11: Report "11";
        Contract21: Report "21";
        Contract23: Report "23";
        Contract24: Report "24";
        Contract25: Report "25";
        Contract99: Report "99";
        Contract101: Report "101";
        Contract103: Report "103";
        Contract111: Report "111";
        Contract119: Report "119";
        Contract122: Report "122";
        Contract127: Report "127";
        Contract128: Report "128";
        Contract214: Report "214";
        Contract299: Report "299";
        Contract301: Report "301";
        Contract309: Report "309";
        Contract310: Report "310";
        Contract311: Report "311";
        Contract328: Report "328";
        Contract402: Report "402";
        Contract702: Report "702";
        Contract711: Report "711";
        Contract721: Report "721";
        Contract722: Report "722";
        Contract780: Report "780";
        Contract789: Report "789";
        Contract801: Report "801";
        Contract5056: Report "5056";*/
        PositonMenuTemp: Record "Position Menu";
        DimensionTemp: Record "Dimension for position";
        PositionTempInsert: Record "Position";
        HeadOf: Record "Head Of's";
        PositionTempInsertNEW: Record "Position";
        DepFindHead: Record "Department";
        ForSis: Record "Sector";
        ForSis1: Record "Department Category";
        PositionFind: Record "Position";
        PositionFind1: Record "Position";
        ECLFind: Record "Employee Contract Ledger";
        DepFind: Record "Department";
        PosMenuFind: Record "Position Menu";
        DepartmentCode: Record "Department";
        BrojZapisa: Integer;
        Entitet: Integer;
        example: Codeunit "Config. Validate Management";
        EmployeeContractLedger2: Record "Employee Contract Ledger";
        EmployeeContractLedger3: Record "Employee Contract Ledger";
        EmployeeContractLedger4: Record "Employee Contract Ledger";
        EmployeeContractLedger5: Record "Employee Contract Ledger";
        EmployeeContractLedger6: Record "Employee Contract Ledger";
        EmployeeContractLedger7: Record "Employee Contract Ledger";
        HeadOfRefresh: Record "Head Of's";
        EmployeeContractLedgerPrevious: Record "Employee Contract Ledger";
        ReportName: Text;
        FileVar: File;
        IStream: InStream;
        MagicPath: Text;
        // FileSystemObject: Automation;
        DestinationFileName: Text;
        CloseDate: Date;
        ECLDate: Record "Employee Contract Ledger";
        DimensionForPosition: Record "Dimension for position";
        EmployeeDefaultDimension: Record "Employee Default Dimension";
        Wagesetup: Record "Wage Setup";
        Text008: Label 'Brutto has to be grater than %1.';
        emphours: Record "Employee";
        PosMenIdentity: Record "Position Menu";
        // Contract22: Report "22";
        Uprava: Text;
        SectorT: Record "Sector";
        PositionCEO: Record "Position";
        MAI2: Record "Misc. Article Information";
        /* Contract88: Report "88";
         Contract87: Report "87";
         Contract115: Report "115";
         Contract129: Report "129";
         Contract187: Report "187";
         Contract188: Report "188";
         Contract189: Report "189";
         Contract190: Report "190";
         Contract191: Report "191";
         Contract192: Report "192";
         Contract193: Report "193";
         Contract215: Report "215";
         Contract216: Report "216";
         Contract291: Report "291";
         Contract292: Report "292";
         Contract296: Report "296";
         Contract297: Report "297";
         Contract319: Report "319";
         Contract322: Report "322";
         Contract324: Report "324";
         Contract406: Report "406";
         Contract407: Report "407";
         Contract408: Report "408";
         Contract410: Report "410";
         Contract412: Report "412";
         Contract415: Report "415";
         Contract416: Report "416";
         Contract417: Report "417";
         Contract418: Report "418";
         Contract491: Report "491";
         Contract496: Report "496";
         Contract497: Report "497";
         Contract498: Report "498";
         Contract499: Report "499";
         Contract298: Report "298";
         Contract5057: Report "5057";
         Contract5058: Report "5058";
         Contract5059: Report "5059";
         Contract5060: Report "5060";
         */
        Department1: Record "Department";
        Duplicate: Integer;
        Department2: Record "Department";
        Duzina1: Integer;
        Duzina2: Integer;
        Number: Integer;
        Orginal: Integer;
        PayRange: Record "Payment range";
        BruttoError: Label 'Brutto isn''t in pay range!';
        Text009: Label 'Start Date this contract must be before the last contract.';
        wb: Record "Work Booklet";
        R_BroughtExperience: Report "Update Brought Experience";
        R_WorkExperience2: Report "Work experience in Company";
        Text010: Label 'Ending Date must not be empty!! Employee no:%1 %2';
        Text011: Label 'Termination date must not be before today';
        Izmjena: Boolean;
        ECL7: Record "Employee Contract Ledger";
        NumberOfProt: Text;
        Empty: Date;
        Pozicije: Record "Position";
        ExternalDate: Record "Employee Contract Ledger";
        Maticna: Codeunit "Employee/Resource Update 2020";

    procedure CreateAttachment()
    var
        Attachment: Record "Attachment";
        InteractTmplLanguage: Record "Employee Contract Ledger";
        WordManagement: Codeunit "WordManagement";
        NewAttachNo: Integer;
    begin
        IF "Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);
            IF NOT CONFIRM(Text001, FALSE) THEN
                EXIT;
        END;

        //NewAttachNo := WordManagement.CreateWordAttachment("Entry No."+''+"Employee No.");
        NewAttachNo := WordManagement.CreateWordAttachment(FORMAT("No.") + ' ' + "Employee No.", 'BOS');
        IF NewAttachNo <> 0 THEN BEGIN
            IF "Attachment No." <> 0 THEN
                RemoveAttachment(FALSE);
            "Attachment No." := NewAttachNo;
            IF InteractTmplLanguage.GET("No.") THEN
                MODIFY
            ELSE
                INSERT;
        END ELSE
            ERROR(Text000);
    end;

    procedure OpenAttachment()
    var
        Attachment: Record "Attachment";
    begin
        /*{IF "Attachment No." = 0 THEN
          EXIT;
        Attachment.GET("Attachment No.");
        {IF Change=TRUE THEN BEGIN
        Attachment.OpenAttachment(FORMAT("No.")+ ' ' + "Employee No.",FALSE,'');}
          END
          ELSE BEGIN}
          CLEAR(ContractR);
          CLEAR(FileManagement);
        DR.SETFILTER("Agreement Code",'%1',"Agremeent Code");
        IF DR.FIND('-') THEN BEGIN
          CRL.SETFILTER("Report ID",'%1',DR."NAV Agreement Code");
          IF CRL.FIND('-') THEN BEGIN
           ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
           IF "Agremeent Code"='26' THEN BEGIN
           { ContractR.SetParam("Employee No.",'26');
             // REPORT.RUNMODAL(DR."NAV Agreement Code");
            ContractR.RUN;}
            ContractR.SetParam("Employee No.",'26');
        
          //REPORT.RUN(60251,FALSE,FALSE);
         // ContractR.RUN; // ovo otvara report kao dialog -- ne treba nam to ovo je problem
        
          tempSaveDest := '\\testhr\uploads\'+FORMAT("Employee No.")+'.docx';
          ContractR.SAVEASWORD(tempSaveDest);
          FileManagement.DownloadToFile(tempSaveDest,tempSaveDest);
            END;
           ReportLayoutSelection.SetTempLayoutSelected(0);
           END;
        
        END;*/
        IF "Attachment No." = 0 THEN
            EXIT;
        Attachment.GET("Attachment No.");
        Attachment.OpenAttachment(FORMAT("No.") + ' ' + "Employee No.", FALSE, '');

    end;

    procedure CopyFromAttachment()
    var
        InteractTmplLanguage: Record "Interaction Tmpl. Language";
        Attachment: Record "Attachment";
        AttachmentManagement: Codeunit "AttachmentManagement";
        NewAttachNo: Integer;
    begin
        IF Attachment.GET("Attachment No.") THEN
            Attachment.TESTFIELD("Read Only", FALSE);

        IF "Attachment No." <> 0 THEN BEGIN
            IF NOT CONFIRM(Text004, FALSE) THEN
                EXIT;
            RemoveAttachment(FALSE);
            "Attachment No." := 0;
            MODIFY;
            COMMIT;
        END;

        //InteractTmplLanguage.SETFILTER("Attachment No.",'<>%1',0);
        //IF PAGE.RUNMODAL(0,InteractTmplLanguage) = ACTION::LookupOK THEN BEGIN
        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
        IF NewAttachNo <> 0 THEN BEGIN
            "Attachment No." := NewAttachNo;
            MODIFY;
        END;
        //END;
    end;

    procedure ImportAttachment()
    var
        Attachment: Record "Attachment";
    begin
        IF "Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);
            /* IF NOT CONFIRM(Text001,FALSE) THEN
               EXIT;*/
        END;
        ECL.RESET;
        ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");
        IF ECL.FIND('-') THEN BEGIN
            BrojUgovora := ECL.COUNT;
        END;
        Attachment.SetParam(Rec."Employee No.", "No.", 1);
        IF Attachment.ImportAttachmentFromClientFile2(HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx', FALSE, FALSE)

       THEN BEGIN
            "Attachment No." := Attachment."No.";
            Change := TRUE;
            MODIFY;
        END;
        HRSetup.GET;
        IF EXISTS(HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx') THEN
            ERASE(HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx');
        /*END ELSE
          ERROR(Text002);*/

    end;

    procedure ExportAttachment()
    var
        TempBlob: Codeunit "Temp Blob";
        MarketingSetup: Record "Marketing Setup";
        FileMgt: Codeunit "File Management";
        FileName: Text[1024];
        FileFilter: Text;
        ExportToFile: Text;
    begin
        MarketingSetup.GET;
        ExportToFile := '';
        IF AttachmentRecord.GET("Attachment No.") THEN
            WITH AttachmentRecord DO BEGIN
                IF "Storage Type" = "Storage Type"::Embedded THEN BEGIN

                    /* // CALCFIELDS(Attachment);
                      //IF Attachment.HASVALUE THEN BEGIN
                          FileName := "Employee No." + '.' + "File Extension";
                          TempBlob.Blob := Attachment;
                          FileMgt.BLOBExport(TempBlob, FileName, TRUE);
                      //END;*/
                END ELSE BEGIN
                    IF "Storage Type" = "Storage Type"::"Disk File" THEN BEGIN
                        IF MarketingSetup."Attachment Storage Type" = MarketingSetup."Attachment Storage Type"::"Disk File" THEN
                            MarketingSetup.TESTFIELD("Attachment Storage Location");
                        FileFilter := UPPERCASE("File Extension") + ' (*.' + "File Extension" + ')|*.' + "File Extension";
                    END;

                    ExportToFile := "Employee No." + '.' + "File Extension";
                    DOWNLOAD(ConstDiskFileName, Text005, '', FileFilter, ExportToFile);
                END;
            END;
    end;

    procedure RemoveAttachment(Prompt: Boolean)
    var
        Attachment: Record "Attachment";
    begin
        IF Attachment.GET("Attachment No.") THEN
            IF Attachment.RemoveAttachment(Prompt) THEN BEGIN
                "Attachment No." := 0;
                MODIFY;
            END;
    end;

    local procedure ConstDiskFileName() DiskFileName: Text[1024]
    begin
        DiskFileName := AttachmentRecord."Storage Pointer" + '\' + FORMAT(AttachmentRecord."No.") + '.';
    end;

    procedure CreateAttachment1()
    var
        Attachment: Record "Attachment";
        InteractTmplLanguage: Record "Employee Contract Ledger";
        WordManagement: Codeunit "WordManagement";
        NewAttachNo: Integer;
    begin
        IF "Other Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Other Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);
            IF NOT CONFIRM(Text001, FALSE) THEN
                EXIT;
        END;

        //NewAttachNo := WordManagement.CreateWordAttachment("Entry No."+''+"Employee No.");
        NewOtherAttachNo := WordManagement.CreateWordAttachment(FORMAT("No.") + ' ' + "Employee No.", 'BOSA');
        IF NewOtherAttachNo <> 0 THEN BEGIN
            IF "Other Attachment No." <> 0 THEN
                RemoveAttachment1(FALSE);
            "Other Attachment No." := NewOtherAttachNo;
            IF InteractTmplLanguage.GET("No.") THEN
                MODIFY
            ELSE
                INSERT;
        END ELSE
            ERROR(Text000);
    end;
    //end;
    // end;

    procedure OpenAttachment1()
    var
        Attachment: Record "Attachment";
    begin
        /*IF "Other Attachment No." = 0 THEN
          EXIT;
        Attachment.GET("Other Attachment No.");
        IF "Change other documents"=TRUE THEN BEGIN
        Attachment.OpenAttachment(FORMAT("No.")+ ' ' + "Employee No.",FALSE,'');
          END
          ELSE BEGIN
            OtherDocumentRegister.SETFILTER("Agreement Code",'%1',"Certifications and solutions C");
        IF OtherDocumentRegister.FIND('-') THEN BEGIN
          CLR4.SETFILTER("Report ID",'%1',OtherDocumentRegister."NAV Agreement Code");
          IF CLR4.FIND('-') THEN BEGIN
           ReportLayoutSelection.SetTempLayoutSelected(CLR4.ID);
            IF "Certifications and solutions C"='210' THEN BEGIN
            ContractTermination.SetParam("Employee No.",'21O');
             ContractTermination.RUN;
             END;
           ReportLayoutSelection.SetTempLayoutSelected(0);
          END;
          END;
          END;*/
        IF "Other Attachment No." = 0 THEN
            EXIT;
        Attachment.GET("Other Attachment No.");
        Attachment.OpenAttachment(FORMAT("No.") + ' ' + "Employee No.", FALSE, '');

    end;

    procedure CopyFromAttachment1()
    var
        InteractTmplLanguage: Record "Interaction Tmpl. Language";
        Attachment: Record "Attachment";
        AttachmentManagement: Codeunit "AttachmentManagement";
        NewAttachNo: Integer;
    begin
        IF Attachment.GET("Other Attachment No.") THEN
            Attachment.TESTFIELD("Read Only", FALSE);

        IF "Other Attachment No." <> 0 THEN BEGIN
            IF NOT CONFIRM(Text004, FALSE) THEN
                EXIT;
            RemoveAttachment1(FALSE);
            "Other Attachment No." := 0;
            MODIFY;
            COMMIT;
        END;

        //InteractTmplLanguage.SETFILTER("Attachment No.",'<>%1',0);
        //IF PAGE.RUNMODAL(0,InteractTmplLanguage) = ACTION::LookupOK THEN BEGIN
        NewOtherAttachNo := AttachmentManagement.InsertAttachment("Other Attachment No.");
        IF NewOtherAttachNo <> 0 THEN BEGIN
            "Other Attachment No." := NewOtherAttachNo;
            MODIFY;
        END;
        //END;
    end;

    procedure ImportAttachment1()
    var
        Attachment: Record "Attachment";
    begin

        IF "Other Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Other Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);
            /* IF NOT CONFIRM(Text001,FALSE) THEN
               EXIT;*/
        END;
        ECL.RESET;
        ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");
        IF ECL.FIND('-') THEN BEGIN
            BrojUgovora := ECL.COUNT;
        END;
        // Attachment.SetParam(Rec."Employee No.", "No.", 3);
        HRSetup.GET;
        IF Attachment.ImportAttachmentFromClientFile(HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx', FALSE, FALSE) THEN BEGIN
            "Attachment No." := Attachment."No.";
        END;
        HRSetup.GET;
        IF EXISTS(HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx') THEN
            ERASE(HRSetup."File Path" + "Employee No." + '-' + FORMAT(BrojUgovora) + '.docx');

    end;

    procedure ExportAttachment1()
    var
        TempBlob: Codeunit "Temp Blob";
        MarketingSetup: Record "Marketing Setup";
        FileMgt: Codeunit "File Management";
        FileName: Text[1024];
        FileFilter: Text;
        ExportToFile: Text;
    begin
        MarketingSetup.GET;
        ExportToFile := '';
        IF AttachmentRecord.GET("Other Attachment No.") THEN
            WITH AttachmentRecord DO BEGIN
                IF "Storage Type" = "Storage Type"::Embedded THEN BEGIN
                    /* CALCFIELDS(Attachment);
                      IF Attachment.HASVALUE THEN BEGIN
                          FileName := "Employee No." + '.' + "File Extension";
                          TempBlob.Blob := Attachment;
                          FileMgt.BLOBExport(TempBlob, FileName, TRUE);
                      END;*/

                end
            END ELSE BEGIN
            //IF "Storage Type" = "Storage Type"::"Disk File" THEN BEGIN
            IF MarketingSetup."Attachment Storage Type" = MarketingSetup."Attachment Storage Type"::"Disk File" THEN
                MarketingSetup.TESTFIELD("Attachment Storage Location");
            // ĐK FileFilter := UPPERCASE("File Extension") + ' (*.' + "File Extension" + ')|*.' + "File Extension";
            //ĐK  ExportToFile := "Employee No." + '.' + "File Extension";
            // ĐK  DOWNLOAD(ConstDiskFileName, Text005, '', FileFilter, ExportToFile);
            // END;
        END;
    END;
    // end;

    procedure RemoveAttachment1(Prompt: Boolean)
    var
        Attachment: Record "Attachment";
    begin
        IF Attachment.GET("Other Attachment No.") THEN
            IF Attachment.RemoveAttachment(Prompt) THEN BEGIN
                "Other Attachment No." := 0;
                MODIFY;
            END;
    end;

    local procedure ConstDiskFileName1() DiskFileName: Text[1024]
    begin
        DiskFileName := AttachmentRecord."Storage Pointer" + '\' + FORMAT(AttachmentRecord."No.") + '.';
    end;

    /* trigger SQLCommand::StatementCompleted(sender: Variant; e: DotNet StatementCompletedEventArgs)
     begin
     end;

     trigger SQLCommand::Disposed(sender: Variant; e: DotNet EventArgs)
     begin
     end;

     trigger SQLConn::InfoMessage(sender: Variant; e: DotNet SqlInfoMessageEventArgs)
     begin
     end;

     trigger SQLConn::StateChange(sender: Variant; e: DotNet StateChangeEventArgs)
     begin
     end;

     trigger SQLConn::Disposed(sender: Variant; e: DotNet EventArgs)
     begin
     end;*/
}

