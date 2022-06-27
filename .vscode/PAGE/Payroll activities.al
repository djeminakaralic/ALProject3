page 50092 "Payroll Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Payroll Cue";
    RefreshOnActivate = true;

    layout
    {

        area(content)
        {
            field(WORKDATE; WORKDATE)
            {
                Caption = 'WorkDate';
                ApplicationArea = all;
            }
            cuegroup(Information)
            {
                Caption = 'Information';
                field("For Calculation"; "For Calculation")
                {
                    ApplicationArea = all;

                }
                field(Calculated; Calculated)
                {

                    ApplicationArea = all;
                }
                field("New Employees FC"; "New Employees FC")
                {
                    Image = Checklist;
                    Importance = Additional;
                    ApplicationArea = all;
                }
                field("Terminated Employees"; "Terminated Employees")
                {
                    Image = Checklist;
                    Importance = Additional;
                    ApplicationArea = all;
                }
                field("Wage Change"; "Wage Change")
                {
                    ApplicationArea = all;
                }
                field("For Calculation Witout Meal"; "For Calculation Witout Meal")
                {
                    ApplicationArea = all;
                }
                field("Negative Payment"; "Negative Payment")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        WageCalc.SETFILTER(Payment, '<%1', 0);
                        PAGE.RUNMODAL(50018, WageCalc);
                    end;
                }
                field(Additions; Additions)
                {
                    ApplicationArea = all;

                }
                field(Transfers; Transfers)
                {
                    ApplicationArea = all;
                    Image = Checklist;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
            cuegroup("Changes")
            {
                Caption = 'Changes';
                field("Surname Change"; "Surname Change")
                {
                    ApplicationArea = all;
                    Image = Checklist;
                    Importance = Additional;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Adress Change"; "Adress Change")
                {
                    ApplicationArea = all;
                    Image = Checklist;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Internal Fund"; "Internal Fund")
                {
                    ApplicationArea = all;
                }
                field("External Fund"; "External Fund")
                {
                    ApplicationArea = all;
                }
                field("Union Employees"; "Union Employees")
                {
                    ApplicationArea = all;
                }
                field("Education Level Change"; "Education Level Change")
                {
                    ApplicationArea = all;
                    Image = Library;
                    Importance = Promoted;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                }

            }
            cuegroup(Contracts)
            {
                Caption = 'Contracts';
                field("Regular Contracts"; "Regular Contracts")
                {
                    ApplicationArea = all;
                }
                field("Temporary Service Contracts"; "Temporary Service Contracts")
                {
                    ApplicationArea = all;
                }
                field("Author Contracts"; "Author Contracts")
                {
                    ApplicationArea = all;
                }
            }
            cuegroup("Wage history")
            {
                Caption = 'Wage history';
                field("Opened calculations"; "Opened calculations")
                {

                    ApplicationArea = all;
                    Image = Cash;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Closed calculations"; "Closed calculations")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;

        // SETFILTER("Due Date Filter",'<=%1',WORKDATE);
        //SETFILTER("Overdue Date Filter",'<%1',WORKDATE);
        // SETFILTER("User ID Filter",USERID);
        // SETRANGE(DateFilter5,CALCDATE('-'+ FORMAT(HRSetup."New employee period"),TODAY),TODAY);
        ThisMonthFirst := CALCDATE('-SM;', WORKDATE);
        ThisMonthLast := CALCDATE('SM', ThisMonthFirst);
        NextMonthFirst := CALCDATE('+1D', ThisMonthLast);
        NextMonthLast := CALCDATE('SM', NextMonthFirst);
        DBThisMonthLast := CALCDATE('SM-1D', ThisMonthFirst);
        DBThisMonthFirst := CALCDATE('-SM-1D;', WORKDATE);
        //SETRANGE(DateFilter6,ThisMonthFirst,ThisMonthLast);
        SETRANGE(DateFilter7, ThisMonthFirst, DBThisMonthLast);
        //SETRANGE(DateFilter8,01011980D,DBThisMonthFirst);
        SETRANGE(DateFilter9, CALCDATE('+1D;', ThisMonthFirst), ThisMonthLast);
        SETRANGE(DateFilterChange, ThisMonthFirst, ThisMonthLast);
    end;

    var

        ThisMonthFirst: Date;
        ThisMonthLast: Date;
        NextMonthFirst: Date;
        NextMonthLast: Date;
        DBThisMonthLast: Date;
        DBThisMonthFirst: Date;
        WageCalc: Record "Wage Calculation";
        WageCalcPage: Page "Wage Calculation Subform";
}

