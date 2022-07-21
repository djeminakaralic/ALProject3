page 50110 "Cashier Activities"
{
    Caption = 'Cashier Activities';
    PageType = CardPart;
    SourceTable = "Cashier Cue";
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

            field("Cash Receipt Journal";"Cash Receipt Journal")
            {
                trigger OnDrillDown()
                begin
                    Page.Run(255);
                end;
            }

            cuegroup(BankAccounts)
            {
                Caption = 'Bank Accounts';
                field("All Bank Accounts"; "All Bank Accounts")
                {
                    ApplicationArea = all;
                }
                field("Bank Accounts"; "Bank Accounts")
                {
                    ApplicationArea = all;
                }
                field(CZK; CZK)
                {
                    ApplicationArea = all;
                }
            }

            cuegroup(AllCustomers)
            {
                Caption = 'Customers';
                field(Customers; Customers)
                {
                    ApplicationArea = all;
                }
            }

        }
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

