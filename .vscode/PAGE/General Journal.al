pageextension 50111 GeneralJournal extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
        modify("Document Type")
        {
            Visible = VisibleI;
        }
        modify("<Document No. Simple Page>")
        {
            Visible = VisibleI;
        }
        modify("<CurrentPostingDate>")
        {
            Visible = VisibleI;
        }
        movebefore(Amount; "Credit Amount")
        moveafter("Credit Amount"; "Debit Amount")

        modify("Account Name")
        {
            Visible = VisibleI;
        }
        modify("<CurrentCurrencyCode>")
        {
            Visible = VisibleI;
        }
        modify("Currency Code")
        {
            Visible = VisibleI;
        }
        modify("EU 3-Party Trade")
        {
            Visible = VisibleI;
        }
        modify("Gen. Posting Type")
        {
            Visible = VisibleI;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = VisibleI;
        }

        modify("Gen. Prod. Posting Group")
        {
            Visible = VisibleI;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = VisibleI;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = VisibleI;
        }
        modify("Total Debit")
        {
            Visible = VisibleI;
        }

        modify("Total Credit")
        {
            Visible = VisibleI;
        }
        modify(IncomingDocAttachFactBox)
        {
            Visible = VisibleI;
        }

        modify("Bal. Gen. Posting Type")
        {
            Visible = VisibleI;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = VisibleI;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = VisibleI;
        }
        modify("Deferral Code")
        {
            Visible = VisibleI;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = VisibleI;
        }
        modify("Business Unit Code")
        {
            Visible = VisibleI;
        }

        modify(AccName)
        {
            Visible = VisibleI;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = VisibleI;
        }
        modify(Control1900919607)
        {
            Visible = VisibleI;
        }
        modify(JournalLineDetails)
        {
            Visible = VisibleI;
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
        modify(Reconcile)
        {
            Visible = VisibleI;
        }
        modify(IncomingDocCard)
        {
            Visible = VisibleI;
        }
        modify(PreviousDocNumberTrx)
        {
            Visible = VisibleI;
        }
        modify(NextDocNumberTrx)
        {
            Visible = VisibleI;
        }
        modify(ClassicView)
        {
            Visible = VisibleI;
        }
        modify(SimpleView)
        {
            Visible = VisibleI;
        }
        modify("New Doc No.")
        {
            Visible = VisibleI;
        }
        modify("Apply Entries")
        {
            Visible = VisibleI;
        }
        // Add changes to page actions here
        modify(Dimensions)
        {
            Visible = VisibleI;
        }
        modify(Card)
        {
            Visible = VisibleI;
        }
        modify("Ledger E&ntries")
        {
            Visible = VisibleI;
        }
        modify(Approvals)
        {
            Visible = VisibleI;
        }
        modify("Renumber Document Numbers")
        {
            Visible = VisibleI;
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            Visible = VisibleI;
        }
        modify(GetStandardJournals)
        {
            Visible = VisibleI;
        }
        modify(SaveAsStandardJournal)
        {
            Visible = VisibleI;
        }
        modify("Remove From Job Queue")
        {
            Visible = VisibleI;
        }

        modify(DeferralSchedule) { Visible = VisibleI; }
        modify(IncomingDocument) { Visible = VisibleI; }
        modify(SelectIncomingDoc) { Visible = VisibleI; }
        modify(IncomingDocAttachFile) { Visible = VisibleI; }
        modify(RemoveIncomingDoc) { Visible = VisibleI; }
        modify("B&ank") { Visible = VisibleI; }
        modify(Application) { Visible = VisibleI; }
        modify("Payro&ll") { Visible = VisibleI; }
        modify("Request Approval") { Visible = VisibleI; }
        modify(SendApprovalRequest) { Visible = VisibleI; }
        modify(SendApprovalRequestJournalBatch) { Visible = VisibleI; }
        modify(SendApprovalRequestJournalLine) { Visible = VisibleI; }
        modify(CancelApprovalRequestJournalBatch) { Visible = VisibleI; }
        modify(CancelApprovalRequestJournalLine) { Visible = VisibleI; }
        modify(SeeFlows) { Visible = VisibleI; }


        modify(CancelApprovalRequest) { Visible = VisibleI; }
        modify(CreateFlow) { Visible = VisibleI; }
        modify(Approval) { Visible = VisibleI; }
        modify(Approve) { Visible = VisibleI; }
        modify(Reject) { Visible = VisibleI; }
        modify(Delegate) { Visible = VisibleI; }
        modify(Comments) { Visible = VisibleI; }

        modify("Opening Balance") { Visible = VisibleI; }
        modify("G/L Accounts Opening balance ") { Visible = VisibleI; }
        modify("Customers Opening balance") { Visible = VisibleI; }
        modify("Vendors Opening balance") { Visible = VisibleI; }

        modify(Page) { Visible = VisibleI; }

        modify(Errors) { Visible = VisibleI; }


    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        WS: Record "Wage Setup";

    begin

        WS.Get();
        if Rec."Journal Batch Name" = WS."Wage Batch Name" then begin
            VisibleI := false;
        end
        else begin
            VisibleI := true;

        end;
    end;


    trigger OnOpenPage()
    var
        myInt: Integer;
        WS: Record "Wage Setup";

    begin

        WS.Get();
        if Rec."Journal Batch Name" = WS."Wage Batch Name" then begin
            VisibleI := false;
        end
        else begin
            VisibleI := true;

        end;




    end;

    var
        myInt: Integer;
        VisibleI: Boolean;
}