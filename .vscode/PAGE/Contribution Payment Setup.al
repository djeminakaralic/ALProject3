page 50118 "Contribution Payment Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Contribution Payments Setup";
    Caption = 'Contribution Payment Setup';

    layout
    {
        area(Content)
        {

            repeater(Group)
            {
                field(Type; Type)
                {

                }
                field(Code; Code)
                {
                    ApplicationArea = All;

                }
                field("Type of Add. Tax"; "Type of Add. Tax")
                {

                }
                field("Payment Receiver1"; "Payment Receiver1")
                {

                }
                field("Payment Receiver2"; "Payment Receiver2")
                {

                }
                field("Payment Receiver3"; "Payment Receiver3")
                {

                }
                field("Payment Account"; "Payment Account")
                {

                }
                field("Revenue Type"; "Revenue Type")
                {

                }
                field("Refer To Number"; "Refer To Number")
                {

                }

                field("Assignment Purpose1"; "Assignment Purpose1")
                {

                }
                field("Assignment Purpose2"; "Assignment Purpose2")
                {

                }
                field("Assignment Purpose3"; "Assignment Purpose3")
                {

                }
                field("Add. Tax Code"; "Add. Tax Code")
                {

                }
                field("G/L Account No."; "G/L Account No.")
                {
                    Visible = false;

                }

                field("Refer To Number RS"; "Refer To Number RS")
                {

                    Visible = false;

                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}