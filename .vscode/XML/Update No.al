xmlport 50008 "Employee No import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;

    schema
    {
        textelement(Root)
        {
            tableelement(Employee; Employee)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Employee';
                UseTemporary = false;
                textelement(JMB)
                {
                    MinOccurs = Zero;
                }
                textelement(Iznos)
                {
                    MinOccurs = Zero;
                }


                trigger OnAfterInsertRecord()
                begin
                    Employee.Reset();
                    Employee.SETFILTER("No.", '%1', Iznos);
                    IF Employee.FINDfirst THEN BEGIN

                        if EmpOLD.get(Employee."No.") then begin
                            EmpOLD.Rename(JMB);
                            Evaluate(IznosInt, JMB);
                            EmpOLD.Order := IznosInt;
                            EmpOLD.Modify();
                        end;




                    END;
                END;

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
    trigger OnPreXMLport()
    var
        myInt: Integer;
    begin

        EmpOLD.Reset();
        EmpOLD.SetFilter("No.", '%1|%2|%3|%4', '111', '96', '12', '172');
        if EmpOLD.FindSet() then
            repeat
                EmpOLD.Delete();
            until EmpOLD.Next() = 0;


    end;

    var
        IznosInt: Integer;
        EmpOLD: Record Employee;
}

