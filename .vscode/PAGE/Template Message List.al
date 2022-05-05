




page 50289 "List of Template Messages"
{
    Caption = 'Template Messages List';
    CardPageID = "E.mail templates";
    PageType = List;
    SourceTable = Template_Message;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; ID)
                {
                }
                field(Type; Type)
                {

                }
                field("Document No."; "Document No.")
                {

                }
                field("Message Code"; "Message Code")
                {
                    Editable = true;
                }
                field("E-mail receiver"; "E-mail receiver")
                {
                    Editable = true;
                }
                field("E-mail sender"; "E-mail sender")
                {
                    Editable = true;

                }
                field("Message Subject"; "Message Subject")
                {
                    Editable = true;
                }
                field("Message Text"; "Message Text")
                {
                    Editable = true;
                }





            }
        }
    }

    actions
    {

        //CR
        area(Processing)
        {
            action("CR dokument")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    ReportCR: Report CR;
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetFilter("No.", '%1', "Document No.");

                    ReportCR.SETTABLEVIEW(SalesHeader);
                    ReportCR.RUN;

                end;
            }
        }

    }
}
