report 50116 "Work experience in Company"
{
    Caption = 'Ukupni obracun staža';
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem1; "Employee")
        {
            column(BroughtYearsofExperience_Employee; DataItem1."Brought Years of Experience")
            {
            }
            column(BroughtMonthsofExperience_Employee; DataItem1."Brought Months of Experience")
            {
            }
            column(BroughtDaysofExperience_Employee; DataItem1."Brought Days of Experience")
            {
            }
            column(YearsofExperienceinCompany_Employee; DataItem1."Years of Experience in Company")
            {
            }
            column(MonthsofExpinCompany_Employee; DataItem1."Months of Exp. in Company")
            {
            }
            column(DaysofExperienceinCompany_Employee; DataItem1."Days of Experience in Company")
            {
            }
            column(YearsofExperience_Employee; DataItem1."Years of Experience")
            {
            }
            column(MonthsofExperience_Employee; DataItem1."Months of Experience")
            {
            }
            column(DaysofExperience_Employee; DataItem1."Days of Experience")
            {
            }
            //BH 01 start
            column(Military_Years_of_Service; DataItem1."Military Years of Service")
            {
            }
            column(Military_Months_of_Service; DataItem1."Military Months of Service")
            {
            }
            column(Military_Days_of_Service; DataItem1."Military Days of Service")
            {
            }
            //BH 01 end

            trigger OnAfterGetRecord()
            var
                EmployeeCL: Record "Work Booklet";
            begin
                //HR01
                //SETFILTER(Status,'%1|%2|%3|%4',0,1,2,3);
                //SETFILTER(Status,'%1|%2',0,1);
                SETFILTER(Status, '<>%1', 4);
                IF EndingDate = 0D THEN EndingDate := TODAY;

                wb.SETCURRENTKEY("Starting Date");
                wb.SETFILTER("Employee No.", '%1', "No.");
                wb.SETFILTER("Current Company", '%1', TRUE);
                wb.SETFILTER(Status, '<>%1', wb.Status::Terminated);
                IF wb.FIND('+') THEN BEGIN
                    wb.CALCFIELDS(Status);
                    IF ((wb.Status.AsInteger() <> 4)) THEN BEGIN
                        IF ((wb."Current Company")) THEN
                            wb.VALIDATE("Ending Date", EndingDate);
                        wb.MODIFY;
                        wb.VALIDATE(Coefficient, wb.Coefficient);
                        wb.MODIFY;
                    END;
                    /*ELSE BEGIN
                      ECL.SETFILTER("Employee No.",'%1',"No.");
                      ECL.SETFILTER("Grounds for Term. Code",'<>%1','');
                      IF ECL.FIND('-') THEN BEGIN
                      IF ((wb."Current Company")) THEN
                    wb.VALIDATE("Ending Date",ECL."Ending Date");
                    wb.MODIFY;
                    END;
                      END;*/
                END;


                UkupnoGodine := 0;
                UkupniDani := 0;
                UkupniMjeseci := 0;

                t_WorkBooklet.SETFILTER("Employee No.", "No.");
                t_WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
                IF t_WorkBooklet.FINDFIRST THEN BEGIN
                    REPEAT
                        t_WorkBooklet.VALIDATE("Ending Date", t_WorkBooklet."Ending Date");
                        t_WorkBooklet.MODIFY(TRUE);
                        IF t_WorkBooklet."Ending Date" = EndingDate THEN
                            t_WorkBooklet.VALIDATE(Coefficient, wb.Coefficient);
                        t_WorkBooklet.MODIFY(TRUE);
                        UkupniDani += t_WorkBooklet.Days;
                        UkupniMjeseci += t_WorkBooklet.Months;
                        UkupnoGodine += t_WorkBooklet.Years;
                    UNTIL t_WorkBooklet.NEXT = 0;

                    t_WorkBookletCurrent.SETCURRENTKEY("Starting Date");
                    t_WorkBookletCurrent.SETFILTER("Employee No.", "No.");
                    t_WorkBookletCurrent.SETFILTER("Current Company", '%1', TRUE);

                    IF t_WorkBookletCurrent.FINDLAST THEN BEGIN
                        TrenutniDani := t_WorkBookletCurrent.Days;
                        TrenutniMjeseci := t_WorkBookletCurrent.Months;
                        TrenutneGodine := t_WorkBookletCurrent.Years;
                    END;
                    HumanResourcesSetup.GET;

                    /*
                    "Days of Experience in Company":=UkupniDani MOD 30;
                    "Months of Exp. in Company":=(UkupniMjeseci+(UkupniDani DIV 30)) MOD 12;
                    "Years of Experience in Company":=UkupnoGodine+ ((UkupniMjeseci+(UkupniDani DIV 30)) DIV 12);*/

                    "Current Days Total" := UkupniDani MOD 30;
                    "Current Months Total" := (UkupniMjeseci + (UkupniDani DIV 30)) MOD 12;
                    "Current Years Total" := UkupnoGodine + ((UkupniMjeseci + (UkupniDani DIV 30)) DIV 12);

                    "Days of Experience in Company" := TrenutniDani MOD 30;
                    "Months of Exp. in Company" := (TrenutniMjeseci + (TrenutniDani DIV 30)) MOD 12;
                    "Years of Experience in Company" := TrenutneGodine + ((TrenutniMjeseci + (TrenutniDani DIV 30)) DIV 12);

                    /*"Brought Years of Exp. in Curr.":=("Current Years Total"-"Years of Experience in Company")+((("Current Months Total"-"Months of Exp. in Company")+(("Current Days Total"-"Days of Experience in Company") DIV 30)) DIV 12);

                    "Brought Months of Exp.in Curr.":=(("Current Months Total"-"Months of Exp. in Company")+(("Current Days Total"-"Days of Experience in Company") DIV 30)) MOD 12;
                    "Brought Days of Exp.in Curr.":=("Current Days Total"-"Days of Experience in Company") MOD 30;

                    BroughtTotal:= "Brought Years of Exp. in Curr."*365+"Brought Months of Exp.in Curr."*12+"Brought Days of Exp.in Curr.";*/

                    "Brought Days of Exp.in Curr." := (UkupniDani - TrenutniDani) MOD 30;
                    "Brought Months of Exp.in Curr." := ((UkupniMjeseci - TrenutniMjeseci) + ((UkupniDani - TrenutniDani) DIV 30)) MOD 12;
                    "Brought Years of Exp. in Curr." := (UkupnoGodine - TrenutneGodine) + (((UkupniMjeseci - TrenutniMjeseci) + ((UkupniDani - TrenutniDani) DIV 30)) DIV 12);
                END ELSE BEGIN
                    "Days of Experience in Company" := 0;
                    "Months of Exp. in Company" := 0;
                    "Years of Experience in Company" := 0;

                    "Brought Years of Exp. in Curr." := 0;
                    "Brought Months of Exp.in Curr." := 0;
                    "Brought Days of Exp.in Curr." := 0;

                    "Current Days Total" := 0;
                    "Current Months Total" := 0;
                    "Current Years Total" := 0;
                END;

                UkupnoGodine := 0;
                UkupniDani := 0;
                UkupniMjeseci := 0;
                MODIFY;


                t_WorkBooklet.RESET;
                t_WorkBooklet.SETFILTER("Employee No.", "No.");
                t_WorkBooklet.SETFILTER("Is not dekra", '%1', FALSE);
                // t_WorkBooklet.SETFILTER("Military Service", '%1', TRUE);//da ne ulazi necheckovan vojni
                IF t_WorkBooklet.FINDFIRST THEN BEGIN
                    REPEAT
                        UkupniDani += t_WorkBooklet.Days;
                        UkupniMjeseci += t_WorkBooklet.Months;
                        UkupnoGodine += t_WorkBooklet.Years;
                    UNTIL t_WorkBooklet.NEXT = 0;


                    HumanResourcesSetup.GET;
                    //pri importu
                    UkupniDani += "Brought Days of Experience 2";
                    UkupniMjeseci += "Brought Months of Experience 2";
                    UkupnoGodine += "Brought Years of Experience 2";
                    IF ((Status.AsInteger() = 0) OR (Status.AsInteger() = 1) OR (Status.AsInteger() = 2) OR (Status.AsInteger() = 3) OR (Status.AsInteger() = 8)) THEN BEGIN
                        "Days of Experience" := UkupniDani MOD 30;
                        "Months of Experience" := (UkupniMjeseci + (UkupniDani DIV 30)) MOD 12;
                        "Years of Experience" := UkupnoGodine + ((UkupniMjeseci + (UkupniDani DIV 30)) DIV 12);
                    END;


                    IF ((Status.AsInteger() = 5) OR (Status.AsInteger() = 6) OR (Status.AsInteger() = 7) OR (Status.AsInteger() = 9) OR (Status.AsInteger() = 10) OR (Status.AsInteger() = 11) OR (Status.AsInteger() = 12)) THEN BEGIN
                        "Days of Experience" := (UkupniDani - "Brought Days of Experience E") MOD 30;
                        "Months of Experience" := ((UkupniMjeseci - "Brought Months of Experience E") + ((UkupniDani - "Brought Days of Experience E") DIV 30)) MOD 12;
                        "Years of Experience" := (UkupnoGodine - "Brought Years of Experience E") + (((UkupniMjeseci - "Brought Months of Experience E") + ((UkupniDani - "Brought Days of Experience E") DIV 30)) DIV 12);

                    END;

                END ELSE BEGIN
                    "Days of Experience" := 0;
                    "Months of Experience" := 0;
                    "Years of Experience" := 0;
                END;

                //"Brought Years Total":=(UkupnoGodine) +((UkupniMjeseci) +((UkupniDani) div 30) ) div 12;
                "Brought Years Total" := ("Brought Years of Exp. in Curr." + "Brought Years of Experience") +
                (("Brought Months of Exp.in Curr." + "Brought Months of Experience") + (("Brought Days of Exp.in Curr." + "Brought Days of Experience") DIV 30)) DIV 12;
                "Brought Months Total" := (("Brought Months of Exp.in Curr." + "Brought Months of Experience") + (("Brought Days of Exp.in Curr." + "Brought Days of Experience") DIV 30)) MOD 12;
                "Brought Days Total" := (("Brought Days of Exp.in Curr." + "Brought Days of Experience") MOD 30);

                //tu

                IF WageSetup.GET THEN BEGIN
                    IF "Org Entity Code" = 'FBIH' THEN BEGIN
                        IF WageSetup."Type Of Work Percentage Calc." = 0 THEN
                            "Work Experience Percentage" := "Current Years Total" * WageSetup."Work Percentage"
                        ELSE
                            "Work Experience Percentage" := "Years of Experience" * WageSetup."Work Percentage";
                    END;

                    IF "Org Entity Code" = 'BD' THEN BEGIN
                        //BD

                        IF WageSetup."Type Of Work Percentage Cal BD" = 0 THEN
                            "Work Experience Percentage" := "Current Years Total" * WageSetup."Work Percentage BD"
                        ELSE
                            "Work Experience Percentage" := "Years of Experience" * WageSetup."Work Percentage BD";

                    END;


                    IF "Org Entity Code" = 'RS' THEN BEGIN
                        // RS
                        IF WageSetup."Type Of Work Percentage Cal RS" = 0 THEN
                            "Work Experience Percentage" := "Current Years Total" * WageSetup."Work Percentage RS"
                        ELSE
                            "Work Experience Percentage" := "Years of Experience" * WageSetup."Work Percentage RS";
                    END;


                    IF "Contribution Category Code" = 'FBIHRS' THEN BEGIN
                        IF WageSetup."Type Of Work Percentage Calc." = 0 THEN
                            "Work Experience Percentage" := "Current Years Total" * WageSetup."Work Percentage"
                        ELSE
                            "Work Experience Percentage" := "Years of Experience" * WageSetup."Work Percentage";
                    END;
                    MODIFY;
                END;
                ECL.SETFILTER("Employee No.", '%1', "No.");
                ECL.SETFILTER(Active, '%1', TRUE);
                IF ECL.FIND('-') THEN
                    ECL.VALIDATE(Brutto, ECL.Brutto);

            end;

            trigger OnPreDataItem()
            begin
                //SETFILTER(Status,'%1',Status::Active);
                //SETFILTER(Status,'%1|%2|%3|%4',0,1,2,3);
                SETFILTER(Status, '<>%1', 4);
                //SETFILTER(Status,'%1|%2',0,1);
                IF EmpNo <> '' THEN
                    SETFILTER("No.", '%1', EmpNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        WorkBooklet.RESET;
        WorkBooklet.SETFILTER(Coefficient, '<>%1', 1);
        WorkBooklet.SETFILTER(Status, '<>%1', WorkBooklet.Status::Terminated);
        IF WorkBooklet.FINDSET THEN
            REPEAT
                IF WorkBooklet."Ending Date" = 0D THEN
                    WorkBooklet."Ending Date" := TODAY;
                WorkBooklet.VALIDATE(Coefficient, WorkBooklet.Coefficient);
                WorkBooklet.MODIFY;

            UNTIL WorkBooklet.NEXT = 0;
        //MESSAGE(Text0001);
        MESSAGE('Završeno');
    end;

    var
        zadnji: Text[100];
        Str: Text[100];
        position: Integer;
        lenght: Integer;
        UkupniDani: Integer;
        UkupnoGodine: Integer;
        t_WorkBooklet: Record "Work Booklet";
        UkupniMjeseci: Integer;
        UkupniDaniBEZ: Integer;
        UkupnoGodineBEZ: Integer;
        UkupniMjeseciBEZ: Integer;
        EmployeeCL: Record "Work Booklet";
        DateRec: Date;
        EmployeeRec: Record "Employee";
        Text0001: Label 'Employee Card is updated.';
        wb: Record "Work Booklet";
        HumanResourcesSetup: Record "Human Resources Setup";
        EndingDate: Date;
        WageSetup: Record "Wage Setup";
        t_WorkBookletCurrent: Record "Work Booklet";
        WorkBooklet: Record "Work Booklet";
        TrenutniDani: Integer;
        TrenutniMjeseci: Integer;
        TrenutneGodine: Integer;
        BroughtTotal: Integer;
        BroughtTotalDays: Integer;
        BroughtTotalMonths: Integer;
        BroughtTotalYears: Integer;
        ECL: Record "Employee Contract Ledger";
        EmpNo: Code[10];

    procedure SetEndingDate(Date: Date)
    begin

        EndingDate := Date;

        //HR01
    end;

    procedure SetEmp(EmployeeNo: Code[10]; Date: Date)
    begin

        EmpNo := EmployeeNo;
        EndingDate := Date;
        //HR01
    end;
}

