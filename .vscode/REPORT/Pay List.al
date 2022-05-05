report 50030 "Pay List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Pay List.rdl';
    Caption = 'Pay List';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(EMPL; Employee)
        {
            DataItemTableView = SORTING("Last Name", "First Name", "Middle Name")
                                ORDER(Ascending)
                                WHERE("Wage Posting Group" = FILTER('FBIH'));
            RequestFilterFields = "No.", "Statistics Group Code", "Emplymt. Contract Code";
            dataitem(DataItem2; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(CompanyName; CompInfo.Name)
                {
                }
                column(t_wageADDesc; t_wageADD.Description)
                {
                }
                column(Address; CompInfo.Address)
                {
                }
                column(Picture; CompInfo.Picture)
                {
                }
                column(PostCode; CompInfo."Post Code")
                {
                }
                column(Ttype; TType)
                {
                }
                column(Wtype; WType)
                {
                }
                column(City; CompInfo.City)
                {
                }
                column(DoW; DoW)
                {
                }
                column(PD; t_WageHeader."Payment Date")
                {
                }
                column(WHNo; t_WageHeader."No.")
                {
                }
                column(DoC; t_WageHeader."Date Of Calculation")
                {
                }
                column(MoC; t_WageHeader."Month of Calculation")
                {
                }
                column(YoC; t_WageHeader."Year of Calculation")
                {
                }
                column(IDYear; IDYear)
                {
                }
                column(IDMonth; IDMonth)
                {
                }
                column(ConCatCode; Employee."Contribution Category Code")
                {
                }
                column(AddTax; Employee."Additional Tax")
                {
                }
                column(GenTax; TempCalc."Tax Deductions")
                {
                }
                column(IndTax; Employee."Tax Individual")
                {
                }
                column(EmployeeID; Employee."Employee ID")
                {
                }
                column(LastName; Employee."Last Name")
                {
                }
                column(FirstName; Employee."First Name")
                {
                }
                column(WEP; Employee."Work Experience Percentage")
                {
                }
                column(No; Employee."No.")
                {
                }
                column(WADesc; Description)
                {
                }
                column(DimText; DimText)
                {
                }
                column(PageNo; PageNo)
                {
                }
                column(WCalcNo; TempCalc."No.")
                {
                }
                column(WageBase; TempCalc."Wage (Base)")
                {
                }
                column(GeneralCoefficient; TempCalc."Employee Coefficient")
                {
                }
                column(FinalNetWage; TempCalc."Final Net Wage")
                {
                }
                column(WageReduction; TempCalc."Wage Reduction")
                {
                }
                column(Payment; TempCalc.Payment)
                {
                }
                column(TaxPerEmployeeNetWage; TempCalc."Net Wage")
                {
                }
                column(TaxLineIndirectWageAdditionAmount; TempCalc."Indirect Wage Addition Amount")
                {
                }
                column(TaxDeductions; TempCalc."Tax Deductions")
                {
                }
                column(tax2; t_WageCalc.Tax)
                {
                }
                column(taxRS; t_WageCalc."Tax (RS)")
                {
                }
                column(TaxBasisRS; t_WageCalc."Tax Basis (RS)")
                {
                }
                column(AmountFromWage; DataItem14."Amount From Wage")
                {
                }
                column(ReportedAmountFromWage; DataItem14."Reported Amount From Wage")
                {
                }
                column(AmountOverWage; DataItem14."Amount Over Wage")
                {
                }
                column(AmountOnWage; DataItem14."Amount On Wage")
                {
                }
                column(AmountOverNeto; DataItem14."Amount Over Neto")
                {
                }
                column(Basis; DataItem14.Basis)
                {
                }
                column(ATPercentageFrom; ATPercentageFrom)
                {
                }
                column(ATPercentageRSFrom; ATPercentageRSFrom)
                {
                }
                column(TaxPercent; TaxPercentage)
                {
                }
                column(CFB; TempCalc."Contribution From Brutto")
                {
                }
                column(COB; TempCalc."Contribution Over Brutto")
                {
                }
                column(CON; TempCalc."Contribution Over Netto")
                {
                }
                column(RegresBrutto; TempCalc."Regres Brutto")
                {
                }
                column(RegresNetto; TempCalc."Regres Netto")
                {
                }
                column(Use; use)
                {
                }
                column(ContrRS; ContrRS)
                {
                }
                dataitem(Sati; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    column(NetAmount; NetAmount)
                    {
                    }
                    column(ABCode; ABCode)
                    {
                    }
                    column(Percentage; Percentage)
                    {
                    }
                    column(Percentagesign; Percentagesign)
                    {
                    }
                    column(SatiDescription; Description)
                    {
                    }
                    column(Quantity; Quantity)
                    {
                    }
                    column(WEB; TempCalc."Work Experience Brutto")
                    {
                    }
                    column(CoeffDif; TempCalc."Coeff. Difference")
                    {
                    }
                    column(UnAbs; TempCalc."Unpaid Absence")
                    {
                    }
                    column(WorkExperiencePercentage; TempCalc."Work Experience Percentage")
                    {
                    }
                    column(ExperienceTotal; TempCalc."Experience Total")
                    {
                    }
                    column(SatiWorkDays; WorkDays)
                    {
                    }
                    column(COAValue; COAValue)
                    {
                    }
                    column(IndividualHourPool; TempCalc."Individual Hour Pool")
                    {
                    }
                    column(TaxableMeal; TempCalc."Taxable Meal")
                    {
                    }
                    column(BruttoMeal; TempCalc."Brutto Meal")
                    {
                    }
                    column(TaxableTransport; TempCalc."Taxable Transport")
                    {
                    }
                    column(BruttoTransport; TempCalc."Brutto Transport")
                    {
                    }
                    column(SatiMealToPay; TempCalc."Meal to pay")
                    {
                    }
                    column(Transport; TempCalc.Transport)
                    {
                    }
                    column(PreostaleUplateNetWage; TempCalc."Net Wage")
                    {
                    }
                    column(PreostaleUplateIndirectWageAdditionAmount; TempCalc."Indirect Wage Addition Amount")
                    {
                    }
                    column(RCFB; TempCalc."Reported Amount From Brutto")
                    {
                    }
                    column(PreostaleUplateWorkDays; WorkDays)
                    {
                    }
                    column(UntaxableWage; TempCalc."Untaxable Wage")
                    {
                    }
                    column(PreostaleUplateMealToPay; TempCalc."Meal to pay")
                    {
                    }
                    column(TaxBasis; TempCalc."Tax Basis")
                    {
                    }
                    column(TaxPerEmployeeAmount; DataItem13.Amount)
                    {
                    }
                    column(NetWageAfterTax; TempCalc."Net Wage After Tax")
                    {
                    }
                    column(ContributionPerEmployeeAmount; "DataItem13".Amount)
                    {
                    }
                    column(ContributionCode_ContributionPerEmployee; DataItem14."Contribution Code")
                    {
                    }
                    column(tax; TempCalc.Tax)
                    {
                    }
                    column(Brutto; TempCalc.Brutto)
                    {
                    }
                    column(HourPool; TempCalc."Hour Pool")
                    {
                    }
                    column(UnpaidAbsence; TempCalc."Unpaid Absence")
                    {
                    }
                    column(Addition; TempCalc."Wage Addition")
                    {
                    }
                    column(UTip; TempCalc."Wage Calculation Type")
                    {
                    }
                    column(WABrutto; TempCalc."Wage Addition")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        AbType.GET(CodeArray[Number]);
                        Description := AbType.Description;


                        Quantity := TotalArray[Number];
                        Value := Quantity * HourWage;
                        Percentage := AbType.Coefficient * 100;
                        ABCode := AbType.Code;

                        IF TempCalc."Calculation Type" = TempCalc."Calculation Type"::Board THEN
                            IF ((WH."Month Of Wage" > 1) AND (WH."Year Of Wage" = 2006)) OR
                               (WH."Year Of Wage" > 2006) THEN
                                SatnicaT := TempCalc."Employee Coefficient"
                            ELSE
                                SatnicaT := TempCalc."Employee Coefficient" * 1.7
                        ELSE
                            SatnicaT := TempCalc."Employee Coefficient";

                        IF AbType."Sick Leave" AND AbType."Sick Leave Paid By Company" THEN BEGIN
                            COAValue := Quantity * SatnicaT * Percentage / 100;

                            SatnicaT := 0;
                        END
                        ELSE
                            IF AbType."Sick Leave" THEN BEGIN
                                COAValue := TempCalc."Sick Fund Total";
                                SatnicaT := 0;
                            END
                            ELSE
                                COAValue := Quantity * SatnicaT * Percentage / 100;
                        IF TempCalc."Wage Calculation Type" <> 0 THEN
                            COAValue := Quantity;
                        /*
                        IF TempCalc."Calculation Type" = TempCalc."Calculation Type"::Board THEN
                         IF (("WH"."Month Of Wage" > 1) AND ("WH"."Year Of Wage" = 2006)) OR
                            ("WH"."Year Of Wage" > 2006) THEN
                             COAValue*=WH."Board Coefficient"/WH."General Coefficient"
                         ELSE
                             COAValue*=1.7;
                        */

                        IF COAValue <> 0 THEN BEGIN
                            TotalNetto += COAValue;
                            TotalHours += Quantity;
                        END;
                        CurrReport.SHOWOUTPUT(NOT AbType."No Report");

                    end;

                    trigger OnPreDataItem()
                    begin
                        Percentagesign := '%';

                        //NK IF EMPL."Contribution Category Code"<>'FBIHRS' THEN
                        ConCat.SETFILTER(Code, '%1', EMPL."Contribution Category Code");
                        //ELSE
                        // ConCat.SETFILTER(Code,'%1','RS');
                        IF ConCat.FINDFIRST THEN BEGIN
                            ConCat.CALCFIELDS("From Brutto");
                            NetAmount := ConCat."From Brutto"
                        END;
                        Absence.RESET;
                        AbCount := 0;
                        Absence.SETRANGE("Employee No.", TempCalc."Employee No.");
                        Absence.SETRANGE("From Date", StartDate, EndDate);
                        //Absence.SETRANGE("Wage Calculation No.", TempCalc."No.");
                        //SPNPL01.02 START
                        Absence.SETFILTER("RS Code", '<>%1', '00');
                        //SPNPL01.02 END
                        IF Absence.FIND('-') THEN
                            REPEAT
                                Found := FALSE;
                                IF AbCount > 0 THEN
                                    FOR I := 1 TO AbCount DO
                                        IF CodeArray[I] = Absence."Cause of Absence Code" THEN BEGIN
                                            TotalArray[I] := TotalArray[I] + Absence.Quantity;
                                            Found := TRUE;
                                        END;
                                IF NOT Found THEN BEGIN
                                    AbCount := AbCount + 1;
                                    CodeArray[AbCount] := Absence."Cause of Absence Code";
                                    TotalArray[AbCount] := Absence.Quantity;
                                END;
                            UNTIL Absence.NEXT = 0;


                        IF AbCount > 0 THEN BEGIN
                            Value := 0;
                            FOR I := 1 TO AbCount DO BEGIN
                                AbType.GET(CodeArray[I]);
                                Value := Value + TotalArray[I] * AbType.Coefficient;
                            END;
                            IF Value <> 0 THEN
                                HourWage := (TempCalc.Brutto - CommissionAmount) / Value
                            ELSE
                                HourWage := 0;
                            SETRANGE(Number, 1, AbCount);
                        END
                        ELSE
                            CurrReport.BREAK;

                        LMHourValue := 0;

                        WorkDays := 0;
                        MealLine.SETRANGE("Employee No.", Employee."No.");
                        IF MealLine.FIND('-') THEN WorkDays := MealLine.Workdays;
                    end;
                }
                dataitem(WAT1; "Wage Addition Type")
                {
                    DataItemTableView = SORTING(Code)
                                        WHERE("Add. Taxable" = CONST(true));
                    dataitem(DataItem5; "Wage Addition")
                    {
                        DataItemLink = "Employee No." = FIELD("No.");
                        DataItemLinkReference = EMPL;
                        DataItemTableView = SORTING("Employee No.", "Year of Wage", "Month of Wage", "Wage Addition Type")
                                            ORDER(Ascending);
                        column(WageAdditionWageTypeT; WageTypeT)
                        {
                        }
                        column(WageAdditionType_WageAddition; "DataItem5"."Wage Addition Type")
                        {
                        }
                        column(Amount_WageAddition; "DataItem5".Amount)
                        {
                        }
                        column(WageAdditionDescription; "DataItem5".Description)
                        {
                        }
                        column(WageAdditionWAJM; WAJM)
                        {
                        }
                        column(WageAdditionWAPerc; WAPerc)
                        {
                        }
                        column(WageAdditionCalculatedAmount; "DataItem5"."Calculated Amount")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

                            WAPerc := 0;
                            IF WAT1."Calculation Type" = WAT1."Calculation Type"::Percentage THEN BEGIN
                                WAPerc := Amount;
                                WAJM := '%';
                            END
                            ELSE
                                WAJM := 'KM';

                            WageTypeT := '';
                            IF STRLEN("Wage Addition Type") > 2 THEN
                                WageTypeT := COPYSTR("Wage Addition Type", 1, 3);
                        end;

                        trigger OnPreDataItem()
                        begin

                            SETRANGE("Month of Wage", IDMonth);
                            SETRANGE("Year of Wage", IDYear);
                            SETRANGE("Wage Calculation Entry No.", TempCalc."No.");
                            SETRANGE("Wage Addition Type", WAT1.Code);
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        WAT1.SETFILTER(Taxable, '%1', FALSE);
                    end;
                }
                dataitem(WAT2; "Wage Addition Type")
                {
                    DataItemTableView = SORTING(Code);
                    dataitem(WA2; "Wage Addition")
                    {
                        DataItemLink = "Employee No." = FIELD("No.");
                        DataItemLinkReference = EMPL;
                        DataItemTableView = SORTING("Employee No.", "Year of Wage", "Month of Wage", "Wage Addition Type")
                                            ORDER(Ascending);
                        column(WA2WageTypeT; WageTypeT)
                        {
                        }
                        column(Taxable_WA2; WA2.Taxable)
                        {
                        }
                        column(EntryNo_WA2; WA2."Entry No.")
                        {
                        }
                        column(WA2Description; WA2.Description)
                        {
                        }
                        column(WA2Perc; WAPerc)
                        {
                        }
                        column(WA2WAJM; WAJM)
                        {
                        }
                        column(WA2CalculatedAmount; WA2."Calculated Amount")
                        {
                        }
                        column(Taxable; WA2.Taxable)
                        {
                        }
                        column(WA2Brutto; WA2."Calculated Amount Brutto")
                        {
                        }
                        column(WA2Netto; WA2."Amount to Pay")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            WAPerc := 0;
                            IF WAT2."Calculation Type" = WAT1."Calculation Type"::Percentage THEN BEGIN
                                WAPerc := Amount;
                                WAJM := '%';
                            END
                            ELSE
                                WAJM := 'KM';

                            TotalNonNetto += "Calculated Amount";

                            WageTypeT := '';
                            IF STRLEN("Wage Addition Type") > 2 THEN
                                WageTypeT := COPYSTR("Wage Addition Type", 1, 3);
                        end;

                        trigger OnPreDataItem()
                        begin

                            SETRANGE("Month of Wage", IDMonth);
                            SETRANGE("Year of Wage", IDYear);
                            SETRANGE("Wage Calculation Entry No.", TempCalc."No.");
                            SETRANGE("Wage Addition Type", WAT2.Code);
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        WAT2.SETFILTER(Taxable, '%1', TRUE);
                    end;
                }
                dataitem(WAT3; "Wage Addition Type")
                {
                    DataItemTableView = SORTING(Code);
                    dataitem(WA3; "Wage Addition")
                    {
                        DataItemLink = "Employee No." = FIELD("No.");
                        DataItemLinkReference = EMPL;
                        DataItemTableView = SORTING("Employee No.", "Year of Wage", "Month of Wage", "Wage Addition Type")
                                            ORDER(Ascending);
                        column(WA3Description; WA3.Description)
                        {
                        }
                        column(WA3CalculatedAmount; WA3."Calculated Amount")
                        {
                        }
                        column(Taxable3; WA3.Taxable)
                        {
                        }
                        column(AddTaxable3; WA3."Add. Taxable")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

                            WA3Sum += WA3."Calculated Amount";
                        end;

                        trigger OnPreDataItem()
                        begin

                            SETRANGE("Month of Wage", IDMonth);
                            SETRANGE("Year of Wage", IDYear);
                            SETRANGE("Wage Calculation Entry No.", TempCalc."No.");
                            SETRANGE("Wage Addition Type", WAT3.Code);
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        WAT3.SETFILTER(Taxable, '%1', FALSE);
                    end;
                }
                dataitem(DataItem9; "Wage Header")
                {
                    DataItemTableView = SORTING("No.", "Entry No.")
                                        ORDER(Ascending)
                                        WHERE("Wage Calculation Type" = FILTER(<> Normal));
                    column(WageHeaderDescription; "DataItem9".Description)
                    {
                    }
                    column(WageHeaderNetWage; WCAdd."Net Wage")
                    {
                    }
                    column(No_WageHeader; "DataItem9"."No.")
                    {
                    }
                    column(DateOfCalculation_WageHeader; "DataItem9"."Date Of Calculation")
                    {
                    }
                    column(MonthOfWage_WageHeader; "DataItem9"."Month Of Wage")
                    {
                    }
                    column(YearOfWage_WageHeader; "DataItem9"."Year Of Wage")
                    {
                    }
                    column(PaymentDate_WageHeader; "DataItem9"."Payment Date")
                    {
                    }
                    column(AverageAddPercentage; "DataItem9"."Average Add Percentage")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        WCAdd.SETRANGE("Entry No.", "Entry No.");
                        IF NOT WCAdd.FIND('-') THEN CurrReport.SKIP;
                    end;

                    trigger OnPreDataItem()
                    begin

                        SETRANGE("No.", WH."No.");
                        WCAdd.SETRANGE("Wage Header No.", WH."No.");
                        WCAdd.SETRANGE("Employee No.", Employee."No.");
                        WCAdd.SETRANGE("No.", TempCalc."No.");
                    end;
                }
                dataitem(HoursFooter; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(UntaxableWage2; TempCalc."Untaxable Wage")
                    {
                    }
                }
                dataitem(DataItem104; "Reduction")
                {
                    column(brrata; DataItem104."No. of Installments")
                    {
                    }
                    column(Isplaceno; RedAmount + DataItem104."Paid Installments")
                    {
                    }
                    column(ostatak_duga; ostatak_duga)
                    {
                    }
                    column(ReductionAmount_Reduction; DataItem104."Reduction Amount")
                    {
                    }
                    column(PaidAmount_Reduction; DataItem104."Paid Amount")
                    {
                    }
                    column(Description_Reduction; DataItem104.Description)
                    {
                    }
                    column(Type_Reduction; DataItem104.Type)
                    {
                    }
                    column(No_Reduction; DataItem104."No.")
                    {
                    }
                    column(Openingbalance; DataItem104."Opening balance")
                    {
                    }
                    column(RedTotal; RedTotal)
                    {
                    }
                    dataitem(DataItem11; "Reduction per Wage")
                    {
                        DataItemLink = "Reduction No." = FIELD("No.");
                        DataItemTableView = SORTING("No.");
                        column(Type; Red.Type)
                        {
                        }
                        column(ReductionPerWageDescription; Red.Description)
                        {
                        }
                        column(ReductionNo_ReductionperWage; "DataItem11"."Reduction No.")
                        {
                        }
                        column(RAmount; RAmount)
                        {
                        }
                        column(ReductionPerWageAmount; "DataItem11".Amount)
                        {
                        }
                        column(ObustaveNo; ObustaveNo)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            Red.GET("Reduction No.");
                            Red.SETFILTER(WHFilter, '<=' + "Wage Header No.");
                            Red.CALCFIELDS("Paid Amount");
                            ObustaveNo += 1;
                            //brrata := Red."No. of Installments";


                            //ostatak_duga := Reduction."Reduction Amount"-Reduction."Paid Amount"-Reduction."Opening balance";
                            /*
                            IF Reduction."Reduction Amount"-Reduction."Paid Amount"-Reduction."Opening balance" < 0 THEN BEGIN
                              ostatak_duga :=0;
                              END
                            ELSE BEGIN
                              ostatak_duga := Reduction."Reduction Amount"-Reduction."Paid Amount"-Reduction."Opening balance";
                              END;
                             */


                        end;

                        trigger OnPreDataItem()
                        begin

                            SETRANGE("Employee No.", TempCalc."Employee No.");
                            SETRANGE("Wage Calculation Entry No.", TempCalc."No.");
                            SETRANGE("Wage Header No.", TempCalc."Wage Header No.");
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CALCFIELDS("No. of Installments paid");
                        RPW.SETFILTER("Date of Calculation", '<=%1', t_WageHeader."Date Of Calculation");
                        RPW.SETFILTER("Employee No.", '%1', "Employee No.");
                        RPW.SETFILTER("Reduction No.", '%1', "No.");
                        IF RPW.FINDSET
                          THEN
                            RedAmount := RPW.COUNT;


                        RPWT.SETFILTER("Date of Calculation", '<=%1', t_WageHeader."Date Of Calculation");
                        RPWT.SETFILTER("Employee No.", '%1', "Employee No.");
                        RPWT.SETFILTER(Type, '%1', 'KREDIT');
                        IF RPWT.FINDSET
                          THEN
                            RPWT.CALCSUMS(Amount);
                        RedTotal := RPWT.Amount;
                    end;

                    trigger OnPreDataItem()
                    begin
                        //SETFILTER(Type,'%1','@*kredit');
                    end;
                }
                dataitem(DataItem13; "Tax Per Employee")
                {
                    DataItemTableView = SORTING("Tax Code")
                                        ORDER(Ascending);

                    trigger OnAfterGetRecord()
                    begin
                        TaxClass.GET("Tax Code");
                    end;

                    trigger OnPreDataItem()
                    begin

                        SETRANGE("Employee No.", TempCalc."Employee No.");
                        SETRANGE("Wage Calculation Entry No.", TempCalc."No.");

                        SETRANGE("Wage Header No.", TempCalc."Wage Header No.");
                    end;
                }
                dataitem(DataItem14; "Contribution Per Employee")
                {
                    DataItemTableView = SORTING("Contribution Code")
                                        ORDER(Ascending);
                    column(ContributionPerEmployeeDescription; at.Description)
                    {
                    }
                    column(ATPercentage; ATPercentage)
                    {
                    }
                    column(ATPercentageRS; ATPercentageRS)
                    {
                    }
                    column(Amount; "DataItem13".Amount)
                    {
                    }
                    column(CNo; CPE."Employee No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        IF (Employee."Contribution Category Code" = 'FBIHRS') OR (Employee."Contribution Category Code" = 'BDPIORS') THEN BEGIN
                            IF ATCatCon.GET('RS', "Contribution Code") THEN
                                IF at.GET("Contribution Code") THEN
                                    ATPercentageRS := ATCatCon.Percentage
                                ELSE
                                    ATPercentageRS := 0;
                        END;

                        IF ATCatCon.GET(Employee."Contribution Category Code", "Contribution Code") THEN
                            IF at.GET("Contribution Code") THEN
                                ATPercentage := ATCatCon.Percentage
                            ELSE
                                ATPercentage := 0;
                    end;

                    trigger OnPreDataItem()
                    begin

                        SETRANGE("Employee No.", TempCalc."Employee No.");
                        SETRANGE("Wage Calc No.", TempCalc."No.");
                        SETRANGE("Wage Header No.", TempCalc."Wage Header No.");
                        ATPercentage := 0;
                        ATPercentageRS := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CPE.SETFILTER("Employee No.", EmployeeFilter);
                    CPE.SETFILTER("Wage Calculation Entry No.", TempCalc."No.");
                    IF CPE.FINDFIRST THEN BEGIN
                        REPEAT
                            IF CPE."Contribution Code" <> 'DJEC-ZAST' THEN
                                ContrRS += CPE."Reported Amount From Wage";
                        UNTIL CPE.NEXT = 0
                    END;

                    IF NOT TempCalc.FIND('-') THEN CurrReport.SKIP;
                    TempCalc.Payment := TempCalc.Payment + TempCalc."Sick Leave-Fund";
                    /*
                     IF TempCalc."Wage Calculation Type"=0 THEN
                        WType:=Text000;
                     IF TempCalc."Wage Calculation Type"=0 THEN
                        TType:=Text004;

                     IF TempCalc."Wage Calculation Type"=1 THEN
                        WType:=Text001;
                     IF TempCalc."Wage Calculation Type"=1 THEN
                         TType:=Text006;

                     IF TempCalc."Wage Calculation Type"=2 THEN
                        WType:=Text002;
                     IF TempCalc."Wage Calculation Type"=2 THEN
                        TType:=Text005;

                     IF TempCalc."Wage Calculation Type"=3 THEN
                        WType:=Text003;
                     IF TempCalc."Wage Calculation Type"=3 THEN
                        TType:=Text004;        */

                    Employee.GET(TempCalc."Employee No.");
                    ConfData.SETFILTER("Position No.", Employee."No.");
                    ConfData.SETFILTER("Segmentation Code", Setup."Commission Code");
                    IF ConfData.FIND('+') THEN
                        EVALUATE(CommissionAmount, ConfData.Description)
                    ELSE
                        CommissionAmount := 0;

                end;

                trigger OnPreDataItem()
                begin

                    CompInfo.GET;
                    TempCalc.RESET;
                    TempCalc.DELETEALL;
                    Setup.GET;
                    StartDate := AF.GetMonthRange(IDMonth, IDYear, TRUE);
                    EndDate := AF.GetMonthRange(IDMonth, IDYear, FALSE);
                    CompInfo.GET;
                    CompInfo.CALCFIELDS(Picture);
                    ei := '0';
                    WH.RESET;
                    WH.SETRANGE("Month Of Wage", IDMonth);
                    WH.SETRANGE("Year Of Wage", IDYear);


                    IF NOT WH.FIND('-') THEN ERROR('Ne postoji taj obračun plata');

                    Calc.RESET;
                    Calc.SETRANGE("Month Of Wage", IDMonth);
                    Calc.SETRANGE("Year of Wage", IDYear);

                    IF EmployeeFilter <> '' THEN
                        Calc.SETFILTER("Employee No.", EmployeeFilter);
                    IF Calc.FIND('-') THEN
                        REPEAT
                            IF TempCalc.GET(Calc."No.") THEN BEGIN
                                //TempCalc."Tax Deductions":= TempCalc."Tax Deductions" + Calc."Tax Deductions";
                                TempCalc."No." := Calc."No.";
                                TempCalc."Work Experience Brutto" := TempCalc."Work Experience Brutto" + Calc."Work Experience Brutto";
                                TempCalc.Brutto := TempCalc.Brutto + Calc.Brutto;
                                TempCalc."Contribution From Brutto" := TempCalc."Contribution From Brutto" + Calc."Contribution From Brutto";
                                TempCalc."Contribution Over Brutto" := TempCalc."Contribution Over Brutto" + Calc."Contribution Over Brutto";
                                TempCalc."Net Wage" := TempCalc."Net Wage" + Calc."Net Wage";
                                TempCalc."Untaxable Wage" := TempCalc."Untaxable Wage" + Calc."Untaxable Wage";
                                TempCalc."Tax Basis" := TempCalc."Tax Basis" + Calc."Tax Basis";
                                TempCalc.Tax := TempCalc.Tax + Calc.Tax;
                                TempCalc."Contribution Per City" := TempCalc."Contribution Per City" + Calc."Contribution Per City";
                                TempCalc."Final Net Wage" := TempCalc."Final Net Wage" + Calc."Final Net Wage";
                                TempCalc."Meal to pay" := TempCalc."Meal to pay" + Calc."Meal to pay";
                                TempCalc.Transport := TempCalc.Transport + Calc.Transport;
                                TempCalc."Wage Reduction" := TempCalc."Wage Reduction" + Calc."Wage Reduction";
                                TempCalc.Payment := TempCalc.Payment + Calc.Payment;
                                TempCalc."Sick Leave-Company" := TempCalc."Sick Leave-Company" + Calc."Sick Leave-Company";
                                TempCalc."Sick Leave-Fund" := TempCalc."Sick Leave-Fund" + Calc."Sick Leave-Fund";
                                TempCalc."Insurance Premium" := TempCalc."Insurance Premium" + Calc."Insurance Premium";
                                TempCalc."Wage Addition" := TempCalc."Wage Addition" + Calc."Wage Addition";
                                TempCalc."Experience Total" += Calc."Experience Total";
                                TempCalc."Sick Fund Total" += Calc."Sick Fund Total";
                                TempCalc."Indirect Wage Addition Amount" += Calc."Indirect Wage Addition Amount";
                                TempCalc."Tax Deductions" += Calc."Tax Deductions";
                                TempCalc."Net Wage After Tax" += Calc."Net Wage After Tax";
                                IF Calc."Wage (Base)" <> 0 THEN
                                    TempCalc."Wage (Base)" := TempCalc."Wage (Base)" + Calc."Wage (Base)";
                                TempCalc.MODIFY;
                            END
                            ELSE BEGIN
                                TempCalc.INIT;

                                //        TempCalc.DELETEALL;

                                TempCalc.TRANSFERFIELDS(Calc);

                                /*TempCalc.SETFILTER("Employee No.",'%1',Calc."Employee No.");
                                TempCalc.SETFILTER("Entry No.",'%1',Calc."Entry No.");*/

                                TempCalc.INSERT;

                                //  TempCalc."No.":= Calc."Employee No.";
                                /*      TempCalc."No.":= FORMAT(Calc."Entry No.");
                                      TempCalc.SETFILTER("Employee No.",'%1',Calc."Employee No.");
                                      TempCalc.SETFILTER("Entry No.",'%1',Calc."Entry No.");
                                    */
                                //TempCalc.SETFILTER("No.",'%1',Calc."Employee No.");

                                /* IF NOT TempCalc.FIND('-') THEN BEGIN
                                    TempCalc."No.":= FORMAT(Calc."Entry No.");
                                  // TempCalc."No.":= Calc."Employee No.";
                                 TempCalc.INSERT;
                                 END
                                 ELSE BEGIN
                                   TempCalc.MODIFY;
                                   END;*/
                            END;
                        UNTIL Calc.NEXT = 0;
                    TempCalc.RESET;
                    //SETRANGE(Broj, 1, TempCalc.COUNT);
                    //SETRANGE(Broj, 1);
                    IsFirst := TRUE;

                    ATCatConFromBrutto.SETFILTER(Code, '%1', TempCalc."Contribution Category Code");

                    IF ATCatConFromBrutto.FINDSET THEN BEGIN

                        ATCatConFromBrutto.CALCFIELDS("From Brutto");
                        ATPercentageFrom := ATCatConFromBrutto."From Brutto";


                    END;
                    IF (TempCalc."Contribution Category Code" = 'FBIHRS') OR (TempCalc."Contribution Category Code" = 'BDPIORS') THEN BEGIN
                        ATCatConFromBruttoRS.SETFILTER(Code, '%1', 'RS');

                        IF ATCatConFromBruttoRS.FINDSET THEN BEGIN

                            ATCatConFromBruttoRS.CALCFIELDS("From Brutto(RS)");
                            ATPercentageRSFrom := ATCatConFromBruttoRS."From Brutto(RS)";


                        END;
                    END;
                    //TaxClass.SETFILTER(Code,'%1',TempCalc."Contribution Category Code");
                    IF TaxClass.FIND('-') THEN
                        TaxPercentage := TaxClass.Percentage;

                    ContrRS := 0;

                end;
            }

            trigger OnAfterGetRecord()
            var
                EmplDefDim: Record "Employee Default Dimension";
            begin
                t_WageHeader.SETFILTER("Month Of Wage", FORMAT(IDMonth));
                t_WageHeader.SETFILTER("Year Of Wage", FORMAT(IDYear));
                //t_WageHeader.SETFILTER("Employee No.","No.");
                t_WageHeader.FINDFIRST;
                t_WageCalc.SETFILTER("Month Of Wage", FORMAT(IDMonth));
                t_WageCalc.SETFILTER("Year of Wage", FORMAT(IDYear));
                t_WageCalc.SETFILTER("Employee No.", "No.");
                IF t_WageCalc.FINDFIRST THEN
                    poruka := 't';
                //begin
                BEGIN
                    EmployeeFilter := "No.";
                    TotalNonNetto := 0;

                    IF TempCalc."Wage Calculation Type" = 0 THEN
                        WType := Text000;
                    IF TempCalc."Wage Calculation Type" = 0 THEN
                        TType := Text004;

                    IF TempCalc."Wage Calculation Type" = 1 THEN
                        WType := Text001;
                    IF TempCalc."Wage Calculation Type" = 1 THEN
                        TType := Text006;

                    IF TempCalc."Wage Calculation Type" = 2 THEN
                        WType := Text002;
                    IF TempCalc."Wage Calculation Type" = 2 THEN
                        TType := Text005;

                    IF TempCalc."Wage Calculation Type" = 3 THEN
                        WType := Text003;
                    IF TempCalc."Wage Calculation Type" = 3 THEN
                        TType := Text004;

                    t_WageCalc.CALCFIELDS("Use Netto");
                    use := t_WageCalc."Use Netto";


                    IF NOT DimValue.GET('PROJECT', "Global Dimension 1 Code") THEN DimValue.INIT;

                    DimText := '';
                    EmplDefDim.SETRANGE("No.", "No.");
                    EmplDefDim.SETRANGE("Dimension Code", 'PROJECT');
                    IF EmplDefDim.FINDFIRST THEN
                        REPEAT
                            DimText += EmplDefDim."Dimension Value Code" + ', ';
                        UNTIL EmplDefDim.NEXT = 0;
                    //end;
                END;
                t_wageADD.SETFILTER("Employee No.", "No.");
                t_wageADD.SETFILTER("Month of Wage", '%1', IDMonth);
                t_wageADD.SETFILTER("Year of Wage", '%1', IDYear);
                IF NOT t_wageADD.FINDFIRST THEN
                    TempCalc.CALCFIELDS("Regres Brutto");
                TempCalc.CALCFIELDS("Regres Netto");
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGE;
                use := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date and year")
                {
                    Caption = 'Month and year';
                    field(Month; IDMonth)
                    {
                        Caption = 'Month';
                    }
                    field(Year; IDYear)
                    {
                        Caption = 'Year';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CLEARALL;
        //IDMonth:=DATE2DMY(CALCDATE('-1M',WORKDATE),2);
        //IDYear:=DATE2DMY(CALCDATE('-1M',WORKDATE),3);
    end;

    trigger OnPreReport()
    begin
        // IDMonth := 12;
        // IDYear := 2016;
        ObustaveNo := 0;
        brrata := 0;




        CASE IDMonth OF
            1:
                DoW := 'Januar';
            2:
                DoW := 'Februar';
            3:
                DoW := 'Mart';
            4:
                DoW := 'April';
            5:
                DoW := 'Maj';
            6:
                DoW := 'Juni';
            7:
                DoW := 'Juli';
            8:
                DoW := 'August';
            9:
                DoW := 'Septembar';
            10:
                DoW := 'Oktobar';
            11:
                DoW := 'Novembar';
            12:
                DoW := 'Decembar';
        END;

        ws.GET;

        MealHeader.RESET;
        MealHeader.SETRANGE("Year Of Wage", IDYear);
        MealHeader.SETRANGE("Month Of Wage", IDMonth);
        IF NOT MealHeader.FIND('-') THEN MealHeader.INIT;
        MealLine.SETRANGE("Document No.", MealHeader."No.");

        CompInfo.GET;
        PageNo := 0;
    end;

    var
        RPWT: Record "Reduction per Wage";
        RedTotal: Decimal;
        RedAmount: Integer;
        RPW: Record "Reduction per Wage";
        ei: Code[10];
        emp: Record "Employee";
        t_wageADD: Record "Wage Addition";
        poruka: Text;
        TType: Text;
        WType: Text[150];
        t_WageCalc: Record "Wage Calculation";
        t_WageHeader: Record "Wage Header";
        TempCalc: Record "Wage Calculation" temporary;
        IDMonth: Integer;
        IDYear: Integer;
        Calc: Record "Wage Calculation";
        EmployeeFilter: Code[20];
        IsFirst: Boolean;
        Employee: Record "Employee";
        ATCatCon: Record "Contribution Category Conn.";
        ATCat: Record "Contribution Category";
        TaxClass: Record "Tax Class";
        Red: Record "Reduction";
        CompInfo: Record "Company Information";
        Post: Record "Post Code";
        CityPercent: Decimal;
        StartDate: Date;
        EndDate: Date;
        AF: Codeunit "Absence Fill";
        Absence: Record "Employee Absence";
        AbCount: Integer;
        CodeArray: array[100] of Code[10];
        TotalArray: array[100] of Decimal;
        Found: Boolean;
        I: Integer;
        Description: Text[50];
        Quantity: Decimal;
        AbType: Record "Cause of Absence";
        Value: Decimal;
        HourWage: Decimal;
        ConfData: Record "Segmentation Data 2";
        Setup: Record "Wage Setup";
        CommissionAmount: Decimal;
        WageType: Record "Wage Type";
        TaxPercent: Decimal;
        ESG: Record "Employee Statistics Group";
        ws: Record "Wage Setup";
        Percentage: Decimal;
        TotalHours: Decimal;
        TotalNetto: Decimal;
        TBasis: Decimal;
        RT: Record "Reduction Types";
        RAmount: Text[30];
        at: Record "Contribution";
        MR: Decimal;
        coa: Record "Cause of Absence";
        COAValue: Decimal;
        EC: Record "Employment Contract";
        WH: Record "Wage Header";
        DoW: Text[150];
        LMHourValue: Decimal;
        SatnicaT: Decimal;
        WCForEC: Record "Wage Calculation";
        WCAdd: Record "Wage Calculation";
        WAAmount: Decimal;
        WAPerc: Decimal;
        TotalNonNetto: Decimal;
        MealHeader: Record "Meal Header";
        MealLine: Record "Meal Line";
        WorkDays: Integer;
        DimValue: Record "Dimension Value";
        DimText: Text[200];
        ABCode: Code[10];
        WAJM: Text[10];
        WageTypeT: Text[30];
        ATPercentage: Decimal;
        PageNo: Integer;
        Txt008: Label 'There is no work day in last 12 months for employee %1';
        RemarksRowNo: Integer;
        ObustaveNo: Integer;
        Text000: Label 'PAY LIST';
        Text001: Label 'UGOVOR O DJELU';
        Text002: Label 'UGOVOR O DJELU';
        Text003: Label 'ISPLATA AUTORSKOG HONORARA';
        Text004: Label 'Porez na dohodak';
        Text005: Label 'Porez na dr. sam. djel. - NER';
        Text006: Label 'Porez na dr. sam. djel. - R';
        Percentagesign: Code[10];
        ATCatConFromBrutto: Record "Contribution Category";
        ATCatConFromBruttoRS: Record "Contribution Category";
        ATCatConOverBrutto: Record "Contribution Category Conn.";
        atfrom: Record "Contribution";
        atover: Record "Contribution";
        ATPercentageFrom: Decimal;
        ConCat: Record "Contribution Category";
        NetAmount: Decimal;
        TaxPercentage: Decimal;
        WC: Record "Wage Calculation";
        ATPercentageRS: Decimal;
        ATPercentageRSFrom: Decimal;
        ContrRS: Decimal;
        CPE: Record "Contribution Per Employee";
        WA3Description: Text;
        WA3Sum: Decimal;
        use: Decimal;
        brrata: Integer;
        ostatak_duga: Decimal;

    procedure GetLastMonthHourValue(var hValue: Decimal; mOfWage: Integer; yOfWage: Integer; EmpTemp: Record "Employee")
    var
        WVE: Record "Wage Value Entry";
        WH: Record "Wage Header";
        AbsEmp: Record "Employee Absence";
        COA: Record "Cause of Absence";
        flagMonth: Boolean;
        mHourPool: Decimal;
        sDate: Date;
        eDate: Date;
        tempCalculator: Integer;
        WC: Record "Wage Calculation";
    begin
        hValue := 0;
        tempCalculator := 12;

        WVE.SETFILTER("Entry Type", '%1', WVE."Entry Type"::"Net Wage");

        WC.RESET;
        WC.SETCURRENTKEY("Wage Header No.", "Employee No.");
        WC.SETFILTER("Employee No.", EmpTemp."No.");

        AbsEmp.RESET;
        AbsEmp.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date", "To Date");


        WHILE hValue = 0 DO BEGIN

            tempCalculator -= 1;
            IF tempCalculator = 0 THEN ERROR(Txt008, EmpTemp."No.");

            IF mOfWage = 1 THEN BEGIN
                yOfWage -= 1;
                mOfWage := 13;
            END;
            mOfWage -= 1;



            sDate := DMY2DATE(1, mOfWage, yOfWage);
            eDate := CALCDATE('<-1D>', CALCDATE('<+1M>', sDate));
            // Moramo naći HourPool za Redovno za mOfWage mjesec, yOfWage godinu
            flagMonth := FALSE;
            mHourPool := 0;
            AbsEmp.SETFILTER("Employee No.", EmpTemp."No.");
            AbsEmp.SETRANGE("From Date", sDate, eDate);
            COA.RESET;
            COA.SETFILTER("Calculation Type", '%1', COA."Calculation Type"::Standard);
            COA.FIND('-');
            REPEAT
                AbsEmp.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                AbsEmp.CALCSUMS(Quantity);
                IF AbsEmp.Quantity <> 0 THEN
                    flagMonth := TRUE;

                mHourPool += AbsEmp.Quantity;
            UNTIL COA.NEXT = 0;


            IF flagMonth THEN BEGIN
                WH.SETFILTER("Year Of Wage", '%1', yOfWage);
                WH.SETFILTER("Month Of Wage", '%1', mOfWage);
                IF NOT WH.FIND('-') THEN ERROR('Plate nisu obrađene za Mjesec:%1, Godinu:%2', mOfWage, yOfWage);

                WVE.SETFILTER("Document No.", WH."No.");
                WVE.SETFILTER("Employee No.", EmpTemp."No.");
                IF NOT WVE.FIND('-') THEN ERROR('Morate imati vrijednosti za prethodni mjesec WVE!');
                REPEAT
                    hValue += WVE."Cost Amount (Actual)";
                UNTIL WVE.NEXT = 0;
                WC.SETFILTER("Wage Header No.", WH."No.");
                WC.CALCSUMS("Experience Total");
                IF hValue <> 0 THEN
                    hValue -= WC."Experience Total";


                IF mHourPool <> 0 THEN
                    hValue /= mHourPool;
            END;
        END;
    end;

    procedure SetPayList(Month: Integer; Year: Integer)
    begin
        IDMonth := Month;
        IDYear := Year;
    end;
}

