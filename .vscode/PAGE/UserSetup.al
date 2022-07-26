pageextension 50107 UserSetup extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Allow Posting To")
        {
            field("Wage Allowed"; "Wage Allowed")
            {
                Caption = 'Wage Allowed';
            }
            field("Main Cashier";"Main Cashier")
            {
                Caption = 'Main Cashier';
            }
        }
        modify("User ID")
        {
            LookupPageId = "User Card";
        }
        modify("Time Sheet Admin.")
        {
            Visible = false;
        }
        modify("Sales Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Service Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Purchase Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        addbefore(Email)
        {
            field("Employee No. for Wage"; "Employee No. for Wage")
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}