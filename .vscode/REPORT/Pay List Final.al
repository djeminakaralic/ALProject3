report 50056 "Pay List Final"
{
    // //NK
    DefaultLayout = RDLC;
    RDLCLayout = './Pay list final.rdl';

    Caption = 'Pay List Final';

    dataset
    {
        dataitem(EMPL; "Employee")
        {
            DataItemTableView = SORTING("Last Name", "First Name", "Middle Name")
                                ORDER(Ascending)
                                WHERE("Wage Posting Group" = FILTER('FBIH'));
            RequestFilterFields = "No.";
            dataitem(DataItem12; "Integer")
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
                column(ConCatCode; Employee."Contribution Category Code")
                {
                }
                column(AddTax; Employee."Additional Tax")
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
                column(WEP; FORMAT(Employee."Work Experience Percentage", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                {
                }
                column(No; Employee."No.")
                {
                }
                column(DimText; DimText)
                {
                }
                column(PageNo; PageNo)
                {
                }
                column(BankAccountNo; BankAccount)
                {
                }
                column(WorkExperiencePercentage; FORMAT(WorkExperiencePercentage, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                {
                }
                column(WageBase; FORMAT(WageBase, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                {
                }
                column(IDMonth; IDMonth)
                {
                }
                column(IDYear; IDYear)
                {
                }
                dataitem(DataItem182; "Wage Value Entry")
                {
                    DataItemTableView = WHERE("Wage Calculation Type" = FILTER('Regular'));
                    column(TotalHours; FORMAT(TotalHours, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(ContributionPercent; ContributionPercent)
                    {
                    }
                    column(ContributionCategory; "DataItem182"."Contribution Category Code")
                    {
                    }
                    column(ContributionOn; ContributionOn)
                    {
                    }
                    column(Umanjenje; Umanjenje)
                    {
                    }
                    column(Akontacija; Akontacija)
                    {
                    }
                    column(PaymentOn; PaymentOn)
                    {
                    }
                    column(BruttoAmountOn; BruttoAmountOn)
                    {
                    }
                    column(PAymentContributionOver; PAymentContributionOver)
                    {
                    }
                    column(PoreskaOsnovica; PoreskaOsnovica)
                    {
                    }
                    column(PAymentNettoOporezivi; PAymentNettoOporezivi)
                    {
                    }
                    column(COAContributioOVer; COAContributioOVer)
                    {
                    }
                    column(PaymentContributionSpecial; PaymentContributionSpecial)
                    {
                    }
                    column(PercenteSpecial; FORMAT(PercenteSpecial, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(WageBaseSpecial; FORMAT(WageBaseSpecial, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(NetoSpecial; FORMAT(NetoSpecial, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(TotalSumSpecial; FORMAT(TotalSumSpecial, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(NettoReduction; NettoReduction)
                    {
                    }
                    column(ReductionCode; ReductionCode)
                    {
                    }
                    column(ReductionText; ReductionText)
                    {
                    }
                    column(Partija; Partija)
                    {
                    }
                    column(ReductionAmount; FORMAT(ReductionAmount, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(ReductionDue; FORMAT(ReductionDue, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(AmountR; FORMAT(AmountR, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(TotalReduction; FORMAT(TotalReduction, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(TotalDue; FORMAT(TotalDue, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(TotalAmountR; FORMAT(TotalAmountR, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(Porez; FORMAT(Porez, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(Coefficient; Coefficient)
                    {
                    }
                    column(BenefitsDed; BenefitsDed)
                    {
                    }
                    column(Postotak; Postotak)
                    {
                    }
                    column(ContributionNezaposlenost; ContributionNezaposlenost)
                    {
                    }
                    column(ContributionNezaposlenostfalse; ContributionNezaposlenostfalse)
                    {
                    }
                    column(PaymentContributionSpecial2; PaymentContributionSpecial2)
                    {
                    }
                    column(COASpecial2; COASpecial2)
                    {
                    }
                    column(PercenteSpecial2; FORMAT(PercenteSpecial2, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(WageBaseSpecial2; FORMAT(WageBaseSpecial2, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(NetoSpecial2; FORMAT(NetoSpecial2, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(TotalSumSpecial2; FORMAT(TotalSumSpecial2, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(COASpecial; COASpecial)
                    {
                    }
                    column(Entry; DataItem182."Entry No.")
                    {
                    }
                    column(EntryValue; EntryValue)
                    {
                    }
                    column(PaymentType; DataItem182.Description)
                    {
                    }
                    column(Amount; DataItem182."Cost Amount (Netto)")
                    {
                    }
                    column(BruttoAmount; DataItem182."Cost Amount (Brutto)")
                    {
                    }
                    column(Name; CompanyInfo.Name)
                    {
                    }
                    column(CEO; CompanyInfo.CEO)
                    {
                    }
                    column(Hours; DataItem182.Hours)
                    {
                    }
                    column(COADescription; UPPERCASE(COADescription))
                    {
                    }
                    column(StartDate; StartDate)
                    {
                    }
                    column(EndDate; EndDate)
                    {
                    }
                    column(COAType; COAType)
                    {
                    }
                    column(ContributionFrom; ContributionFrom)
                    {
                    }
                    column(ContributionOver; ContributionOver)
                    {
                    }
                    column(ReductionType; ReductionType)
                    {
                    }
                    column(Reduction; DataItem182."Reduction Type")
                    {
                    }
                    column(Contribution; DataItem182."Contribution Type")
                    {
                    }
                    column(ATFrom; DataItem182."AT From")
                    {
                    }
                    column(ATFromNetto; DataItem182."AT From neto")
                    {
                    }
                    column(Basis; DataItem182.Basis)
                    {
                    }
                    column(PaymentTotal; PAymentNetto)
                    {
                    }
                    column(ReductiionTotal; PaymentRed)
                    {
                    }
                    column(ContributionFromTotal; PaymentContribution)
                    {
                    }
                    column(ContributionOverTotal; PAymentContributionOver)
                    {
                    }
                    column(BruttoTotal; PaymentBrutto)
                    {
                    }
                    column(ContrRS; ContrRS)
                    {
                    }
                    column(NetoPlaca; FORMAT(NetoPlaca, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(UkupanDohodak; FORMAT(UkupanDohodak, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
                    {
                    }
                    column(NetoZaIsplatu; NetoZaIsplatu)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        PaymentOrder.RESET;
                        PaymentOrder.SETFILTER(SvrhaDoznake3, '%1', "Employee No.");
                        PaymentOrder.SETFILTER("Wage Header No.", '%1', "Document No.");
                        PaymentOrder.SETFILTER(Contributon, '%1', 'PLAĆA');
                        IF PaymentOrder.FINDFIRST THEN
                            BankAccount := PaymentOrder.RacunPrimaoca

                        ELSE BEGIN
                            BankAccount := Employee."Bank Account No.";
                        END;

                        EmployeeRec.RESET;
                        EmployeeRec.SETFILTER("No.", '%1', EmployeeFilter);
                        IF EmployeeRec.FINDFIRST THEN BEGIN
                            //Coefficient:=EmployeeRec."Benefit Coefficient";
                            //BenefitsDed:=EmployeeRec."Tax Deduction Amount";

                            WageCalculation.RESET;
                            WageCalculation.SETFILTER("Employee No.", '%1', EmployeeFilter);
                            WageCalculation.SETFILTER("Wage Header No.", '%1', WH."No.");
                            IF WageCalculation.FINDFIRST THEN BEGIN
                                ws.GET;
                                WorkExperiencePercentage := WageCalculation."Work Experience Percentage";

                                // Coefficient:=WageCalculation."Tax Deductions"/ws."Base Tax Deduction";

                                /*IF ws."Base Tax Deduction"<>0 THEN BEGIN



                                   IF ((WageCalculation."Contribution Category Code"='FBIH') OR (WageCalculation."Contribution Category Code"='FBIHRS') ) THEN

                                     Coefficient:=WageCalculation."Tax Deductions"/ws."Base Tax Deduction";

                                      IF ((WageCalculation."Contribution Category Code"='RS')) THEN

                                    Coefficient:=WageCalculation."Tax Deductions"/ws."Base Tax Deduction RS";

                                        IF ((WageCalculation."Contribution Category Code"='BDPIOFBIH') OR (WageCalculation."Contribution Category Code"='BDPIORS')) THEN

                                     Coefficient:=WageCalculation."Tax Deductions"/ws."Base Tax Deduction BD";



                                END;*/

                                IF (WageCalculation."Contribution Category Code" = 'FBIH') OR (WageCalculation."Contribution Category Code" = 'FBIHRS') THEN BEGIN
                                    TaxDed.RESET;
                                    TaxDed.SETFILTER("Entity Code", '%1', 'FBIH');
                                    TaxDed.SETFILTER("Valid Year", '<=%1', WageCalculation."Year of Wage");
                                    TaxDed.SETFILTER(Month, '<=%1', WageCalculation."Month Of Wage");
                                    TaxDed.SETCURRENTKEY("Valid Year", Month);
                                    TaxDed.ASCENDING;
                                    IF TaxDed.FINDLAST THEN
                                        Coefficient := WageCalculation."Tax Deductions" / TaxDed.Amount
                                    ELSE
                                        Coefficient := 0;
                                END;


                                IF (WageCalculation."Contribution Category Code" = 'RS') THEN BEGIN
                                    TaxDed.RESET;
                                    TaxDed.SETFILTER("Entity Code", '%1', 'RS');
                                    TaxDed.SETFILTER("Valid Year", '<=%1', WageCalculation."Year of Wage");
                                    TaxDed.SETFILTER(Month, '<=%1', WageCalculation."Month Of Wage");
                                    TaxDed.SETCURRENTKEY("Valid Year", Month);
                                    TaxDed.ASCENDING;
                                    IF TaxDed.FINDLAST THEN
                                        Coefficient := WageCalculation."Tax Deductions" / TaxDed.Amount
                                    ELSE
                                        Coefficient := 0;
                                END;

                                IF ((WageCalculation."Contribution Category Code" = 'BDPIOFBIH') OR (WageCalculation."Contribution Category Code" = 'BDPIORS')) THEN BEGIN
                                    TaxDed.RESET;
                                    TaxDed.SETFILTER("Entity Code", '%1', 'BD');
                                    TaxDed.SETFILTER("Valid Year", '<=%1', WageCalculation."Year of Wage");
                                    TaxDed.SETFILTER(Month, '<=%1', WageCalculation."Month Of Wage");
                                    TaxDed.SETCURRENTKEY("Valid Year", Month);
                                    TaxDed.ASCENDING;
                                    IF TaxDed.FINDLAST THEN
                                        Coefficient := WageCalculation."Tax Deductions" / TaxDed.Amount
                                    ELSE
                                        Coefficient := 0;
                                END;







                                IF WageCalculation."Contribution Category Code" = 'RS' THEN
                                    Coefficient := 0;
                                BenefitsDed := WageCalculation."Tax Deductions";
                            END;


                        END
                        ELSE BEGIN
                            Coefficient := 0;
                            BenefitsDed := 0;
                            WorkExperiencePercentage := 0;
                        END;

                        COADescription := '';
                        COA.RESET;
                        COA.SETFILTER("Short Code", '%1', Description);
                        IF COA.FINDFIRST THEN BEGIN
                            COADescription := COA.Description;
                        END
                        ELSE BEGIN
                            WAT.RESET;
                            WAT.SETFILTER(Code, '%1', Description);
                            IF WAT.FINDFIRST THEN BEGIN
                                COADescription := WAT.Description;
                                IF WAT.Code = '820' THEN
                                    WAT.Code := '990';


                            END
                            ELSE BEGIN
                                Red.RESET;
                                Red.SETFILTER(Code, '%1', Description);
                                IF Red.FINDFIRST THEN BEGIN
                                    COADescription := Red.Description;
                                END
                                ELSE BEGIN
                                    Contribution.RESET;

                                    Contribution.SETFILTER("Short Code", '%1', Description);

                                    IF Description = '' THEN
                                        Contribution.SETFILTER(Code, '%1', FORMAT("Contribution Type"));
                                    IF Contribution.FINDFIRST THEN BEGIN
                                        COADescription := Contribution.Description;
                                        ContributionCategory.RESET;
                                        ContributionCategory.SETFILTER("Contribution Code", '%1', "Contribution Type");
                                        WageCalculation.RESET;
                                        WageCalculation.SETFILTER("Employee No.", '%1', EmployeeFilter);
                                        WageCalculation.SETFILTER("Wage Header No.", '%1', WH."No.");
                                        IF WageCalculation.FINDFIRST THEN
                                            ContributionCategory.SETFILTER("Category Code", '%1', WageCalculation."Contribution Category Code");
                                        ContributionCategory.SETFILTER("Over Brutto", '%1', FALSE);
                                        IF ContributionCategory.FINDFIRST THEN
                                            ContributionNezaposlenost := ContributionCategory.Percentage;
                                        ContributionCategory.RESET;
                                        ContributionCategory.SETFILTER("Contribution Code", '%1', "Contribution Type");
                                        WageCalculation.RESET;
                                        WageCalculation.SETFILTER("Employee No.", '%1', EmployeeFilter);
                                        WageCalculation.SETFILTER("Wage Header No.", '%1', WH."No.");
                                        IF WageCalculation.FINDFIRST THEN
                                            ContributionCategory.SETFILTER("Category Code", '%1', WageCalculation."Contribution Category Code");
                                        ContributionCategory.SETFILTER("Over Brutto", '%1', TRUE);
                                        IF ContributionCategory.FINDFIRST THEN
                                            ContributionNezaposlenostfalse := ContributionCategory.Percentage;
                                        ContributionCategory.RESET;
                                        ContributionCategory.SETFILTER("Contribution Code", '%1', "Contribution Type");
                                        IF ContributionCategory.FINDFIRST THEN BEGIN
                                            PercenteSpecial := ContributionCategory.Percentage;
                                            IF WageCalculation."Contribution Category Code" = 'RS' THEN
                                                PercenteSpecial := 0;

                                            WageBaseSpecial := DataItem182.Basis;
                                            NetoSpecial := DataItem182."Cost Amount (Netto)";

                                        END;



                                    END
                                    ELSE
                                        IF Description = '999' THEN
                                            COADescription := 'Minuli rad';
                                    IF Description = '830' THEN
                                        COADescription := 'Naknada za prevoz u novcu';



                                END;
                            END;
                        END;




                        WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                        WVE.SETFILTER("Document No.", '%1', WH."No.");
                        WVE.SETFILTER("Entry Type", '%1|%2|%3|%4|%5|%6|%7',
                        WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Use, WVE."Entry Type"::"Work Experience",
                        WVE."Entry Type"::Taxable, WVE."Entry Type"::Untaxable, WVE."Entry Type"::"Meal to pay", WVE."Entry Type"::Transport);
                        //2,12,14,13,11,7,9);
                        IF WVE.FINDFIRST THEN BEGIN
                            WVE.CALCSUMS("Cost Amount (Netto)");
                            WVE.CALCSUMS("Cost Amount (Brutto)");
                            PAymentNetto := WVE."Cost Amount (Netto)";
                            PaymentBrutto := WVE."Cost Amount (Brutto)";
                        END;



                        WVE2.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE2.SETFILTER("Document No.", '%1', WH."No.");
                        WVE2.SETFILTER("Reduction Type", '<>%1', '');
                        WVE2.SETFILTER("Wage Calculation Type", '%1', WVE2."Wage Calculation Type"::Regular);
                        //2,12,14,13,11,7,9);
                        IF WVE2.FINDFIRST THEN BEGIN
                            WVE2.CALCSUMS("Cost Amount (Netto)");
                            PaymentRed := WVE2."Cost Amount (Netto)";
                        END;


                        WVE3.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE3.SETFILTER("Document No.", '%1', WH."No.");
                        WVE3.SETFILTER("AT From", '%1', TRUE);
                        WVE3.SETFILTER("Wage Calculation Type", '%1', WVE3."Wage Calculation Type"::Regular);
                        //2,12,14,13,11,7,9);
                        IF WVE3.FINDFIRST THEN BEGIN
                            WVE3.CALCSUMS("Cost Amount (Netto)");
                            PaymentContribution := WVE3."Cost Amount (Netto)";
                        END;

                        WVE4.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE4.SETFILTER("Document No.", '%1', WH."No.");
                        WVE4.SETFILTER("AT From", '%1', FALSE);
                        WVE4.SETFILTER("AT From neto", '%1', FALSE);
                        WVE4.SETFILTER("Contribution Type", '<>%1', '');
                        WVE4.SETFILTER("Wage Calculation Type", '%1', WVE4."Wage Calculation Type"::Regular);
                        //2,12,14,13,11,7,9);
                        IF WVE4.FINDFIRST THEN BEGIN
                            WVE4.CALCSUMS("Cost Amount (Netto)");
                            PAymentContributionOver := WVE4."Cost Amount (Netto)";
                        END;

                        WVE.RESET;
                        WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE.SETFILTER("Document No.", '%1', WH."No.");
                        WVE.SETFILTER("AT From neto", '%1', TRUE);
                        WVE.SETFILTER("Entry Type", '%1', "Entry Type"::Contribution);
                        WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                        IF WVE.FINDFIRST THEN BEGIN
                            WVE.CALCSUMS("Cost Amount (Netto)");
                            TotalSumSpecial := WVE."Cost Amount (Netto)";
                        END;





                        WVE.RESET;
                        WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE.SETFILTER("Document No.", '%1', WH."No.");
                        WVE.SETFILTER("Entry Type", '%1|%2', DataItem182."Entry Type"::"Net Wage", DataItem182."Entry Type"::Taxable);
                        WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                        //2,12,14,13,11,7,9);
                        TotalHours := 0;
                        IF WVE.FINDSET THEN
                            REPEAT
                                TotalHours := TotalHours + WVE.Hours;
                            UNTIL WVE.NEXT = 0;


                        WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE.SETFILTER("Document No.", '%1', WH."No.");
                        WVE.SETFILTER("Entry Type", '%1|%2|%3|%4|%5|%6',
                        WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Use, WVE."Entry Type"::"Work Experience",
                        WVE."Entry Type"::Taxable, WVE."Entry Type"::Untaxable, WVE."Entry Type"::"Meal to pay");
                        WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                        WVE.SETFILTER("Cost Amount (Brutto)", '<>%1', 0);
                        //2,12,14,13,11,7,9);
                        IF WVE.FINDFIRST THEN BEGIN
                            WVE.CALCSUMS("Cost Amount (Netto)");
                            WVE.CALCSUMS("Cost Amount (Brutto)");
                            PAymentNettoOporezivi := WVE."Cost Amount (Netto)";
                            WVE.RESET;
                            WVE.SETFILTER("Employee No.", '%1', DataItem182."Employee No.");
                            WVE.SETFILTER("Document No.", '%1', DataItem182."Document No.");
                            WVE.SETFILTER("Cost Amount (Brutto)", '<>%1', 0);
                            WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                            WVE.SETFILTER(Description, '%1', '820');
                            IF WVE.FINDFIRST THEN
                                PAymentNettoOporezivi := PAymentNettoOporezivi - WVE."Cost Amount (Netto)";

                            // PaymentBrutto:=WVE."Cost Amount (Brutto)";
                        END;






                        IF DataItem182."Entry Type" = DataItem182."Entry Type"::Reduction THEN BEGIN
                            ReductionCode := DataItem182."Reduction Type";
                            ReductionTypes.RESET;
                            ReductionTypes.SETFILTER(Code, '%1', ReductionCode);
                            IF ReductionTypes.FINDFIRST THEN BEGIN
                                ReductionText := ReductionTypes.Description;
                                EntryValue := DataItem182."Entry No.";
                                ReductionList.RESET;
                                ReductionList.SETFILTER("No.", '%1', DataItem182."Reduction No.");
                                IF ReductionList.FINDFIRST THEN BEGIN
                                    Partija := ReductionList."Party No.";
                                    ReductionAmount := ReductionList."Reduction Amount";
                                    //ReductionDue:=ReductionList."Remaining Due";
                                    //ReductionDue:=ReductionList."Reduction Amount"-(ReductionList."Opening balance"+ReductionList."Paid Amount");
                                    ReductionPerEmployee.RESET;
                                    ReductionPerEmployee.SETFILTER("Employee No.", '%1', DataItem182."Employee No.");
                                    ReductionPerEmployee.SETFILTER("Wage Header No.", '<=%1', DataItem182."Document No.");
                                    ReductionPerEmployee.SETFILTER("Reduction No.", '%1', ReductionList."No.");
                                    IF ReductionPerEmployee.FINDFIRST THEN BEGIN
                                        ReductionPerEmployee.CALCSUMS(Amount);
                                        IF NOT ReductionTypes.AmountIsPercentage THEN
                                            ReductionDue := ReductionList."Reduction Amount" - ReductionPerEmployee.Amount - ReductionList."Opening balance"
                                        ELSE
                                            ReductionDue := 0;
                                    END
                                    ELSE BEGIN
                                        ReductionDue := 0;
                                    END;
                                    AmountR := DataItem182."Cost Amount (Netto)";
                                    TotalReduction := TotalReduction + ReductionAmount;
                                    TotalDue := TotalDue + ReductionDue;
                                    TotalAmountR := TotalAmountR + AmountR;

                                END;
                            END;
                            AmountR := DataItem182."Cost Amount (Netto)";
                            //TotalAmountR:=TotalAmountR+AmountR;
                            CALCSUMS("Cost Amount (Netto)");
                        END;
                        IF TotalAmountR = 0 THEN BEGIN
                            WVE.RESET;
                            WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                            WVE.SETFILTER("Document No.", '%1', WH."No.");
                            WVE.SETFILTER("Entry Type", '%1', DataItem182."Entry Type"::Reduction);
                            WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                            //2,12,14,13,11,7,9);
                            IF WVE.FINDFIRST THEN BEGIN
                                WVE.CALCSUMS("Cost Amount (Netto)");
                                TotalAmountR := WVE."Cost Amount (Netto)";
                            END;
                            TotalReduction := TotalReduction + ReductionAmount;
                        END;


                        //  UNTIL WVE.NEXT=0;
                        WVE.RESET;
                        WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE.SETFILTER("Document No.", '%1', WH."No.");
                        WVE.SETFILTER("Entry Type", '%1', DataItem182."Entry Type"::Reduction);
                        WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                        TotalReduction := 0;
                        TotalDue := 0;
                        //TotalAmountR:=0;
                        IF WVE.FINDSET THEN
                            REPEAT

                                ReductionList.RESET;
                                ReductionList.SETFILTER("No.", '%1', WVE."Reduction No.");
                                IF ReductionList.FINDFIRST THEN BEGIN
                                    TotalReduction := TotalReduction + ReductionList."Reduction Amount";
                                    TotalDue := TotalDue + ReductionList."Remaining Due";
                                    //TotalAmountR:=TotalAmountR+WVE."Cost Amount (Netto)";
                                END;
                            //END;

                            UNTIL WVE.NEXT = 0;



                        CompanyInfo.GET;
                        WVE.RESET;
                        WVE.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        WVE.SETFILTER("Document No.", '%1', WH."No.");
                        WVE.SETFILTER("Entry Type", '%1', DataItem182."Entry Type"::Tax);
                        WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                        IF WVE.FINDFIRST THEN
                            Porez := WVE."Cost Amount (Netto)";
                        RecordTaxClass.RESET;
                        //   RecordTaxClass.SETFILTER(Active, '%1', TRUE);
                        IF COPYSTR(WVE."Contribution Category Code", 1, 2) = 'RS' THEN
                            RecordTaxClass.SETFILTER(Code, '%1', WVE."Contribution Category Code")
                        ELSE
                            RecordTaxClass.SETFILTER("Entity Code", '%1', CompanyInfo."Entity Code");
                        //    RecordTaxClass.SETFILTER(Active, '%1', TRUE);
                        IF RecordTaxClass.FINDFIRST THEN BEGIN

                            Postotak := RecordTaxClass.Percentage;

                        END;


                        Umanjenje := 0;
                        PoreskaOsnovica := 0;
                        Akontacija := 0;
                        NetoPlaca := PAymentNettoOporezivi;
                        UkupanDohodak := PAymentNetto;

                        Calc.RESET;
                        Calc.SETRANGE("Month Of Wage", IDMonth);
                        Calc.SETRANGE("Year of Wage", IDYear);
                        Calc.SETFILTER("Employee No.", '%1', "DataItem182"."Employee No.");
                        IF Calc.FINDFIRST THEN BEGIN
                            IF Calc."Contribution Category Code" = 'RS' THEN BEGIN
                                Umanjenje := BenefitsDed;
                                PoreskaOsnovica := Calc."Tax Basis";
                                Akontacija := ((Calc."Tax Basis") * Postotak) / 100;
                                NetoPlaca := PAymentNettoOporezivi - ((Calc."Tax Basis") * Postotak) / 100;
                                //UkupanDohodak:=PAymentNetto-((PAymentNettoOporezivi-BenefitsDed)*Postotak)/100;
                                UkupanDohodak := PAymentNetto - Porez;


                            END
                            ELSE BEGIN


                                IF PAymentNettoOporezivi - BenefitsDed < 0 THEN BEGIN
                                    Umanjenje := 0;
                                    PoreskaOsnovica := 0;
                                    Akontacija := 0;
                                    NetoPlaca := PAymentNettoOporezivi;
                                    UkupanDohodak := PAymentNetto;
                                END
                                ELSE BEGIN
                                    Umanjenje := BenefitsDed;
                                    PoreskaOsnovica := PAymentNettoOporezivi - BenefitsDed;
                                    Akontacija := ((PAymentNettoOporezivi - BenefitsDed) * Postotak) / 100;
                                    NetoPlaca := PAymentNettoOporezivi - ((PAymentNettoOporezivi - BenefitsDed) * Postotak) / 100;
                                    //UkupanDohodak:=PAymentNetto-((PAymentNettoOporezivi-BenefitsDed)*Postotak)/100;
                                    UkupanDohodak := PAymentNetto - Porez;
                                END;
                            END;

                        END;


                        NetoZaIsplatu := UkupanDohodak - TotalAmountR;

                        /*
                        WCh.SETFILTER("No.",'%1',"Employee No.");
                        IF NOT WCh.FINDFIRST THEN BEGIN
                        WCh.INIT;
                        WCh."No.":="Employee No.";
                        WCh.Payment:= NetoZaIsplatu;
                        WCh.INSERT;
                        END;*/

                    end;

                    trigger OnPreDataItem()
                    begin
                        //SETFILTER("Entry Type",'%1|%2|%3|%4|%5|%6|%7|%8|%9',2,6,7,9,10,11,12,13,14);

                        WH.RESET;
                        WH.SETRANGE("Month Of Wage", IDMonth);
                        WH.SETRANGE("Year Of Wage", IDYear);


                        //IF NOT WH.FIND('-') THEN ERROR('Ne postoji taj obračun plata');
                        Calc.RESET;
                        Calc.SETRANGE("Month Of Wage", IDMonth);
                        Calc.SETRANGE("Year of Wage", IDYear);

                        IF Calc.FINDFIRST THEN BEGIN
                            DataItem182."Document No." := Calc."Wage Header No.";
                        END
                        ELSE BEGIN
                            DataItem182."Document No." := '';
                        END;





                        SETFILTER("Entry Type", '<>%1', 0);

                        CompanyInfo.GET;
                        COADescription := '';
                        Base := 0;
                        WHNo := GETFILTER("Document No.");
                        IF WHNo <> '' THEN BEGIN
                            WageHeader.GET(WHNo);
                            StartDate := AbsenceFill.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", TRUE);
                            EndDate := AbsenceFill.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", FALSE);

                            //StartDate:=IDMonth;
                            //EndDate:=IDYear;

                        END;


                        COAType := FALSE;
                        ContributionFrom := FALSE;
                        ContributionOver := FALSE;
                        ReductionType := FALSE;
                        Percentage := 0;
                        emp := GETFILTER("Employee No.");
                        PAymentNetto := 0;
                        PaymentBrutto := 0;
                        PaymentContribution := 0;
                        PAymentContributionOver := 0;
                        PaymentRed := 0;
                        COADescription := '';
                        TotalSumSpecial := 0;
                        TotalAmountR := 0;
                        NetoPlaca := 0;
                        UkupanDohodak := 0;

                        IF StartDate = 0D THEN BEGIN
                            StartDate := AbsenceFill.GetMonthRange(IDMonth, IDYear, TRUE);
                            EndDate := AbsenceFill.GetMonthRange(IDMonth, IDYear, FALSE);
                        END;
                        SETFILTER("Employee No.", '%1', EmployeeFilter);
                        SETFILTER("Document No.", '%1', WH."No.");
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


                    Employee.GET(TempCalc."Employee No.");
                    ConfData.SETFILTER("Position No.", Employee."No.");
                    ConfData.SETFILTER("Segmentation Code", Setup."Commission Code");
                    IF ConfData.FIND('+') THEN
                        EVALUATE(CommissionAmount, ConfData.Description)
                    ELSE
                        CommissionAmount := 0;
                    /*
                    WageCalculation.RESET;
                     WageCalculation.SETFILTER("Wage Header No.",'%1',WH."No.");
                     WageCalculation.SETFILTER("Employee No.",'%1',EmployeeFilter);
                     IF WageCalculation.FINDLAST THEN BEGIN
                     WageBase:=WageCalculation."Wage (Base)";
                     END
                      ELSE BEGIN
                      WageBase:=0;
                    END;*/

                    ECL.RESET;
                    FinalDate := ABSFill.GetMonthRange(IDMonth, IDYear, FALSE);
                    ECL.RESET;
                    ECL.SETFILTER("Employee No.", '%1', EmployeeFilter);
                    ECL.SETFILTER("Starting Date", '<=%1', FinalDate);
                    ECL.SETFILTER("Ending Date", '%1|>=%2', 0D, FinalDate);
                    ECL.SETFILTER("Show Record", '%1', TRUE);
                    ECL.SETCURRENTKEY("Starting Date");
                    ECL.ASCENDING;
                    IF ECL.FINDLAST THEN BEGIN
                        WageBase := ECL.Brutto;
                    END
                    ELSE BEGIN
                        ECL.RESET;
                        ECL.SETFILTER("Employee No.", '%1', EmployeeFilter);
                        ECL.SETFILTER("Starting Date", '<=%1', FinalDate);
                        ECL.SETFILTER("Ending Date", '%1|>=%2', 0D, StartDate);
                        ECL.SETFILTER("Show Record", '%1', TRUE);
                        ECL.SETCURRENTKEY("Starting Date");
                        ECL.ASCENDING;
                        IF ECL.FINDLAST THEN BEGIN
                            WageBase := ECL.Brutto;

                        END;
                    END;

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
                    IF DepartmentR <> '' THEN
                        Calc.SETFILTER("Department Code", DepartmentR);
                    IF EmployeeFilter <> '' THEN
                        Calc.SETFILTER("Employee No.", EmployeeFilter);
                    IF Calc.FIND('-') THEN
                        REPEAT
                            IF TempCalc.GET(Calc."No.") THEN BEGIN
                            END
                            ELSE BEGIN

                                TempCalc.INIT;



                                TempCalc.TRANSFERFIELDS(Calc);



                                TempCalc.INSERT;
                            END;
                        UNTIL Calc.NEXT = 0;
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

                END;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGE;
                use := 0;
                BankAccount := '';
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
                        ApplicationArea = all;
                        Caption = 'Month';
                    }
                    field(Year; IDYear)
                    {
                        ApplicationArea = all;
                        Caption = 'Year';
                    }
                    field(DepartmentR; DepartmentR)
                    {
                        ApplicationArea = all;
                        Caption = 'Depaartment';
                        TableRelation = Department;
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
        IDMonth := DATE2DMY(CALCDATE('0D', WORKDATE), 2);
        IDYear := DATE2DMY(CALCDATE('0D', WORKDATE), 3);
    end;

    trigger OnPreReport()
    begin
        // IDMonth := 12;
        // IDYear := 2016;
        ObustaveNo := 0;

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
        PaymentOrder: Record "Payment Order";
        BankAccount: Code[20];
        DepartmentR: Code[20];
        ei: Code[10];
        t_wageADD: Record "Wage Addition";
        poruka: Text;
        TType: Text;
        WType: Text[150];
        t_WageCalc: Record "Wage Calculation";
        t_WageHeader: Record "Wage Header";
        PoreskaOsnovica: Decimal;
        TempCalc: Record "Wage Calculation" temporary;
        IDMonth: Integer;
        IDYear: Integer;
        EmployeeFilter: Code[20];
        ReductionPerEmployee: Record "Reduction per Wage";
        IsFirst: Boolean;
        Employee: Record "Employee";
        Umanjenje: Decimal;
        ATCatCon: Record "Contribution Category Conn.";
        ABSFill: Codeunit "Absence Fill";
        ATCat: Record "Contribution Category";
        TaxClass: Record "Tax Class";
        Red: Record "Reduction types";
        Akontacija: Decimal;
        CompInfo: Record "Company Information";
        Post: Record "Post Code";
        CityPercent: Decimal;
        AF: Codeunit "Absence Fill";
        Absence: Record "Employee Absence";
        AbCount: Integer;
        CodeArray: array[100] of Code[10];
        TotalArray: array[100] of Decimal;
        TaxDed: Record "Tax deduction list";
        Found: Boolean;
        FinalDate: Date;
        I: Integer;
        Description: Text[50];
        Quantity: Decimal;
        AbType: Record "Cause of Absence";
        Value: Decimal;
        HourWage: Decimal;
        ConfData: Record "Segmentation Data";
        Setup: Record "Wage Setup";
        CommissionAmount: Decimal;
        WageType: Record "Wage Type";
        TaxPercent: Decimal;
        // ESG: Record "Misc. Article Information (B)";
        ws: Record "Wage Setup";
        TotalHours: Decimal;
        TotalNetto: Decimal;
        TBasis: Decimal;
        RT: Record "Reduction types";
        RAmount: Text[30];
        at: Record "Contribution";
        MR: Decimal;
        COAValue: Decimal;
        EC: Record "Employment Contract";
        DoW: Text[150];
        LMHourValue: Decimal;
        SatnicaT: Decimal;
        WCForEC: Record "Wage Calculation";
        WCAdd: Record "Wage Calculation";
        ",": Decimal;
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
        WA3Description: Text;
        WA3Sum: Decimal;
        use: Decimal;
        T_HumanResourceSetup: Record "Human Resources Setup";
        CompanyInfo: Record "Company Information";
        COA: Record "Cause of Absence";
        COADescription: Text[250];
        WAT: Record "Wage Addition Type";
        AbsenceFill: Codeunit "Absence Fill";
        StartDate: Date;
        EndDate: Date;
        WHNo: Text;
        WageHeader: Record "Wage Header";
        Contribution: Record "Contribution";
        COAType: Boolean;
        ContributionFrom: Boolean;
        ContributionOver: Boolean;
        ReductionType: Boolean;
        COADescriptionR: Text[250];
        Percentage: Decimal;
        ContributionPercentage: Record "Contribution Category Conn.";
        WVE: Record "Wage Value Entry";
        emp: Code[10];
        PAymentNetto: Decimal;
        PaymentBrutto: Decimal;
        PaymentContribution: Decimal;
        PaymentRed: Decimal;
        WVE2: Record "Wage Value Entry";
        WVE3: Record "Wage Value Entry";
        WVE4: Record "Wage Value Entry";
        PAymentContributionOver: Decimal;
        CPE: Record "Contribution Per Employee";
        Base: Decimal;
        EmployeeRec: Record "Employee";
        BankAccountNo: Code[30];
        FirstName: Text;
        LastName: Text;
        WorkExperiencePercentage: Decimal;
        WageBase: Decimal;
        WageCalculation: Record "Wage Calculation";
        PaymentType: Text;
        BruttoAmount: Decimal;
        TaxAll: Decimal;
        PAymentNetto2: Decimal;
        ContributionPercent: Decimal;
        ContributionCategory: Record "Contribution Category Conn.";
        ContributionOn: Text;
        PaymentOn: Text;
        BruttoAmountOn: Decimal;
        Orderby: Integer;
        RedovanRad: Text;
        RedovanRad2: Text;
        BrutoRedovan: Decimal;
        GO: Text;
        GO2: Text;
        BrutoGO: Decimal;
        Vjerski: Text;
        Vjerski2: Text;
        BrutoVjerski: Decimal;
        HoursRed: Integer;
        HoursGo: Integer;
        HoursVje: Integer;
        RedovanNeto: Decimal;
        GONeto: Decimal;
        VjerskiNeto: Decimal;
        Meal: Text;
        Meal2: Text;
        BrutoMeal: Decimal;
        NetoMeal: Decimal;
        Meal1: Text;
        Meal12: Text;
        BrutoMeal1: Decimal;
        NetoMeal1: Decimal;
        Brojac: Integer;
        Hours2: Integer;
        COADescription2: Text;
        PaymentType2: Text;
        BruttoAmount2: Decimal;
        COADescription3: Text;
        PaymentType3: Text;
        BruttoAmount3: Decimal;
        NettoAmount3: Decimal;
        Transport: Decimal;
        COADescription4: Text;
        PaymentType4: Text;
        PAymentNettoOporezivi: Decimal;
        PaymentContribution2: Text;
        ContributionR: Record "Contribution";
        COAContributioOVer: Text;
        PercenteC: Decimal;
        WageBaseContri: Decimal;
        NetoCont: Decimal;
        TotalSumCon: Decimal;
        TotalPercent: Decimal;
        TotalSumSpecial: Decimal;
        PaymentContributionSpecial: Text;
        COASpecial: Text;
        PercenteSpecial: Decimal;
        WageBaseSpecial: Decimal;
        NetoSpecial: Decimal;
        NettoReduction: Decimal;
        ReductionCode: Code[10];
        ReductionText: Text;
        ReductionTypes: Record "Reduction types";
        ReductionList: Record "Reduction";
        Partija: Text;
        ReductionAmount: Decimal;
        ReductionDue: Decimal;
        AmountR: Decimal;
        TotalReduction: Decimal;
        TotalDue: Decimal;
        TotalAmountR: Decimal;
        Porez: Decimal;
        Coefficient: Decimal;
        BenefitsDed: Decimal;
        RecordTaxClass: Record "Tax Class";
        Postotak: Decimal;
        COADescriptionTopli: Integer;
        COADescription5: Text;
        PenzijCode: Text;
        PenzijDescription: Text;
        ContributionPenzij: Decimal;
        BrutoPenzij: Decimal;
        ZdravCode: Text;
        ZdravDescription: Text;
        ContributionZdrav: Decimal;
        BrutoZdrav: Decimal;
        NezaposlenostCode: Text;
        NezaposlenostDescription: Text;
        ContributionNezaposlenost: Decimal;
        BrutoNezaposlenost: Decimal;
        TotalCont: Decimal;
        PenzijCodefalse: Text;
        PenzijDescriptionfalse: Text;
        ContributionPenzijfalse: Decimal;
        BrutoPenzijfalse: Decimal;
        ZdravCodefalse: Text;
        ZdravDescriptionfalse: Text;
        ContributionZdravfalse: Decimal;
        BrutoZdravfalse: Decimal;
        NezaposlenostCodefalse: Text;
        NezaposlenostDescriptionfalse: Text;
        ContributionNezaposlenostfalse: Decimal;
        BrutoNezaposlenostfalse: Decimal;
        TotalContfalse: Decimal;
        Brojac2: Integer;
        PaymentContributionSpecial2: Text;
        COASpecial2: Text;
        PercenteSpecial2: Decimal;
        WageBaseSpecial2: Decimal;
        NetoSpecial2: Decimal;
        TotalSumSpecial2: Decimal;
        EntryValue: Integer;
        WH: Record "Wage Header";
        Calc: Record "Wage Calculation";
        NetoPlaca: Decimal;
        UkupanDohodak: Decimal;
        NetoZaIsplatu: Decimal;
        ECL: Record "Employee Contract Ledger";

    procedure SetPayList(Month: Integer; Year: Integer)
    begin
        IDMonth := Month;
        IDYear := Year;
    end;
}

