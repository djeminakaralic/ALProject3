pageextension 50147 JournalLineDetailsFactBox extends "Journal Line Details FactBox"
{
    layout
    {

        modify(Account)
        {
            Caption = 'Kupac';
        }
        /*        <trans-unit id="Page 3897649796 - Control 1267408499 - Property 2879900210" size-unit="char" translate="yes" xml:space="preserve">
          <source>Account</source>
          <target>Račun</target>
          <note from="Developer" annotates="general" priority="2"></note>
          <note from="Xliff Generator" annotates="general" priority="3">Page Journal Line Details FactBox - Control Account - Property Caption</note>
        </trans-unit>*/

        modify(PostingGroup)
        {
            Visible = false;
        }
        modify(GenPostingSetup)
        {
            Visible = false;
        }
        modify(VATPostingSetup)
        {
            Visible = false;
        }
        modify(BalAccount)
        {
            Visible = false;
        }


        addafter(AccountName)
        {
            field(Phone_Cust; Phone_Cust)
            {
                Caption = 'Kućni telefonski broj';
                ApplicationArea = All;
            }
            field(MobilePhone_Cust; MobilePhone_Cust)
            {
                Caption = 'Broj mobilnog telefona';
                ApplicationArea = All;
            }
            field(Email_Cust; Email_Cust)
            {
                Caption = 'E-mail';
                ApplicationArea = All;
            }
            field(Address_Cust; Address_Cust)
            {
                Caption = 'Adresa';
                ApplicationArea = All;
            }
            field(City_Cust; City_Cust)
            {
                Caption = 'Grad';
                ApplicationArea = All;
            }
            field("Posting Group"; "Posting Group")
            {
                Caption = 'Knjižna grupa';
                ApplicationArea = All;
            }
        }
    }
}