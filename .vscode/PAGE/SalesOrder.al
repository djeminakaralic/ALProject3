pageextension 50094 SalesOrder extends "Sales Order"
{
    layout
    {

        // Add changes to page layout here
        addafter(Status)
        {
            field("Language Code"; "Language Code")
            {

            }
        }
        addafter("Salesperson Code")
        {
            field("Bank No."; "Bank No.")
            {
                Caption = 'Šifra banke';
            }
        }
        addafter("Posting Date")
        {
            field("VAT Date"; "VAT Date")
            {

            }
        }
        addafter("Language Code")
        {
            field("Note 1"; "Note 1")
            {
                Caption = 'Note 1';

            }
            field("Note 2"; "Note 2")
            {
                Caption = 'Note 2';
            }
            field("Note 3"; "Note 3")
            {
                Caption = 'Note 3';
            }
            field("Message Code"; "Message Code")
            {

            }
            field(Documents; Documents)
            {
                DrillDown = true;
                trigger OnDrillDown()
                var
                    DocumentList: Page "Document List";
                    DocumentRec: Record Documents;
                    templateM: Record Template_Message;

                begin
                    DocumentRec.Reset();
                    DocumentRec.SetFilter("Document No", '%1', Rec."No.");
                    DocumentList.SetTableView(DocumentRec);
                    DocumentList.Run();

                end;


            }
        }
        addafter("Invoice Details")
        {
            group("CR")
            {
                field("CR included"; "CR included")
                {

                }
                field(Orderer; Orderer)
                {

                }
                field("Contract Number"; "Contract Number")
                {

                }
                field("Order person"; "Order person")
                {

                }
                field("Responsible Person"; "Responsible Person")
                {

                }
                field("Responsible Person Infodom"; "Responsible Person Infodom")
                {

                }
                field(Designer; Designer)
                {

                }
                field("Project manager"; "Project manager")
                {

                }
                field("HD Number"; "HD Number")
                {

                }
                field("Area covered by changes"; "Area covered by changes")
                {

                }
                field("Person/hours"; "Person/hours")
                {
                    Visible = false;
                }
                field("Amount without VAT"; "Amount without VAT")
                {
                    Visible = false;

                }
                field(Deadline; Deadline)
                {

                }
                field(seriousness; seriousness)
                {

                }
                field("Templates for CR"; "Templates for CR")
                {

                }
            }
        }



    }

    actions
    {
        // Add changes to page actions here
        addafter("Print Confirmation")
        {
            action("Prepare mail notification")
            {
                Caption = 'Prepare mail notification';
                Ellipsis = true;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    DocumentAdd: Record Documents;
                    Attachments: array[10] of Integer;
                    AttachmentsName: array[10] of Text;
                    ReportLayoutSelection: Record "Report Layout Selection";
                    CRL: Record "Custom Report Layout";
                    MailSending: Report "Mail Sending";

                begin

                    //max 10 priloga
                    i := 1;
                    IF Rec.FINDFIRST THEN
                        REPEAT
                            DocumentAdd.Reset();
                            DocumentAdd.SetFilter("Document No", '%1', Rec."No.");
                            if DocumentAdd.FindSet() then
                                repeat

                                    Attachments[i] := DocumentAdd."Attachment No";
                                    AttachmentsName[i] := DocumentAdd."Document Name";
                                    i += 1;
                                    IF i >= 10 THEN
                                        BREAK;
                                until DocumentAdd.Next() = 0;

                        until Rec.Next() = 0;
                    CLEAR(ReportLayoutSelection);
                    CRL.RESET;
                    CRL.SETFILTER("Report ID", '%1', 50080);
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(CRL.Code);

                        MailSending.SetParam(Attachments, AttachmentsName, rec."No.", 0, '', '', '', Rec."Message Code");
                        MailSending.RUN;
                    END;
                    COMMIT;

                end;


            }

            action("Send mail notification2")
            {
                Caption = 'Send mail notification';
                Ellipsis = true;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    DocumentAdd: Record Documents;
                    Attachments: array[10] of Integer;
                    AttachmentsName: array[10] of Text;
                    ReportLayoutSelection: Record "Report Layout Selection";
                    CRL: Record "Custom Report Layout";
                    MailSending: Report "Mail Sending2";

                begin

                    //max 10 priloga
                    i := 1;
                    IF Rec.FINDFIRST THEN
                        REPEAT
                            DocumentAdd.Reset();
                            DocumentAdd.SetFilter("Document No", '%1', Rec."No.");
                            if DocumentAdd.FindSet() then
                                repeat

                                    Attachments[i] := DocumentAdd."Attachment No";
                                    AttachmentsName[i] := DocumentAdd."Document Name";
                                    i += 1;
                                    IF i >= 10 THEN
                                        BREAK;
                                until DocumentAdd.Next() = 0;

                        until Rec.Next() = 0;
                    CLEAR(ReportLayoutSelection);
                    CRL.RESET;
                    CRL.SETFILTER("Report ID", '%1', 50084);
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(CRL.Code);

                        MailSending.SetParam(Attachments, AttachmentsName, rec."No.", 0, '', '', '', Rec."Message Code");
                        MailSending.RUN;
                    END;
                    COMMIT;

                end;


            }


        }
    }

    var
        myInt: Integer;
        i: Integer;
}