pageextension 50111 GeneralJournal extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Account Name")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }

        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify("Bal. Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        modify("Business Unit Code")
        {
            Visible = false;
        }

        modify(AccName)
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify(Control1900919607)
        {
            Visible = false;
        }
        modify(JournalLineDetails)
        {
            Visible = false;
        }




        addafter("Posting Date")
        {
            field("Line No."; "Line No.")
            {

            }
        }

    }


    actions
    {

        addafter(PostAndPrint)
        {
            action("Change Date")
            {
                Caption = 'Change Date';
                ApplicationArea = all;
                Image = DateRange;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    GenJournal: Record "Gen. Journal Line";
                    Text003: Label 'Do you want to change date in journal to current date?';
                begin

                    IF CONFIRM(Text003) THEN BEGIN
                        GenJournal.SETFILTER("Document No.", '<>%1', '');
                        IF GenJournal.FINDFIRST THEN
                            REPEAT
                                GenJournal.VALIDATE("Posting Date", TODAY);
                                GenJournal.VALIDATE("Document Date", TODAY);
                                GenJournal.MODIFY;
                            UNTIL GenJournal.NEXT = 0;
                    END;
                    MESSAGE('Promjena je izvrsena. Osvježite stranicu da biste vidjeli nalog sa tekućim datumom');


                end;



            }
        }
        // Add changes to page actions here
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(Card)
        {
            Visible = false;
        }
        modify("Ledger E&ntries")
        {
            Visible = false;
        }
        modify(Approvals)
        {
            Visible = false;
        }
        modify("Renumber Document Numbers")
        {
            Visible = false;
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            Visible = false;
        }
        modify(GetStandardJournals)
        {
            Visible = false;
        }
        modify(SaveAsStandardJournal)
        {
            Visible = false;
        }
        modify("Remove From Job Queue")
        {
            Visible = false;
        }
        modify(DeferralSchedule) { Visible = false; }
        modify(IncomingDocument) { Visible = false; }
        modify(SelectIncomingDoc) { Visible = false; }
        modify(IncomingDocAttachFile) { Visible = false; }
        modify(RemoveIncomingDoc) { Visible = false; }
        modify("B&ank") { Visible = false; }
        modify(Application) { Visible = false; }
        modify("Payro&ll") { Visible = false; }
        modify("Request Approval") { Visible = false; }
        modify(CancelApprovalRequest) { Visible = false; }
        modify(CreateFlow) { Visible = false; }
        modify(Approval) { Visible = false; }
        modify("Opening Balance") { Visible = false; }
        modify(Page) { Visible = false; }
        modify(Errors) { Visible = false; }

    }


    var
        myInt: Integer;
}