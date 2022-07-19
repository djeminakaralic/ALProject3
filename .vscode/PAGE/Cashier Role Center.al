page 50107 "Cashier Role Center"
{
    Caption = 'Cashier', Comment = '{Dependency=Match,"ProfileDescription_Payroll"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control139; "Cashiergreeting")
            {
                ApplicationArea = all;
                Visible = true;

            }
            part("Cashier Activities"; "Cashier Activities")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        /*area(processing)
        {                   
            group("Pay Lists2")
            {
                Caption = 'Pay Lists';
                Image = Statistics;
                action("Pay Lists")
                {
                    ApplicationArea = all;
                    Caption = 'Pay Lists';
                    Image = Recalculate;
                    RunObject = Report "Pay List Final";
                }
            }          
        }*/
        area(reporting)
        {          

            action("Nalog knjiženja gotovinskih uplata")
            {
                ApplicationArea = all;
                Caption = 'Nalog knjiženja gotovinskih uplata';
                Image = Report;
                RunObject = Page "Cash Receipt Journal";
            }                    
        }
    }
}


