 //
//  Document.swift
//  RaiseMan
//
//  Created by 马志彬 on 16/10/22.
//  Copyright © 2016年 马志彬. All rights reserved.
//

import Cocoa

class Document: NSDocument, NSWindowDelegate{
    
    
    @IBOutlet var arrayController: NSArrayController!
    @IBOutlet weak var tableView: NSTableView!
    
    private var KVOContext = 0
    
    dynamic var employees: [Employee] = []
        {
        willSet {
            for employee in employees {
                removeObservingEmployee(employee: employee)
            }
        }
        didSet {
            for employee in employees {
                startObservingEmployee(employee: employee)
            }
        }
    }
    
    var v = 1
    var counter = 1;

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
//        let e2 = Employee()
//        e2.name = "3"
//        employees2.insert(e2, at: 0)

    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }

    override func data(ofType typeName: String) throws -> Data {
        tableView.window?.endEditing(for: nil)
        return NSKeyedArchiver.archivedData(withRootObject: employees)
    }
    
    override func read(from data: Data, ofType typeName: String) throws {
        Swift.print("read from data of type \(typeName)")
        
        employees = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Employee]
    }
    
    override func windowControllerDidLoadNib(_ windowController: NSWindowController) {
        super.windowControllerDidLoadNib(windowController)
    }


    // MARK: - Accessors
    
    override func mutableArrayValue(forKey key: String) -> NSMutableArray {
        return super.mutableArrayValue(forKey: key)
    }
    func insertObject(_ employee: Employee, inEmployeesAtIndex index: Int) {
        Swift.print("insert employee \(employee) at \(index)")
        undoManager?.registerUndo(withTarget: self, handler: {target in
            target.removeObject(fromEmployeesAtIndex: index)
        })
        undoManager?.setActionName("Add Employee")
        employees.append(employee)
    }
    
    func removeObject(fromEmployeesAtIndex index: Int) {
        Swift.print("remove employee at \(index)")
        let employee = self.employees[index]
        undoManager?.registerUndo(withTarget: self){ target in
            target.insertObject(employee, inEmployeesAtIndex: index)
        }
        undoManager?.setActionName("Remove Employee")
        employees.remove(at: index)
    }

    
    // MARK: - Key Value Observing
    
    func startObservingEmployee(employee: Employee){
        employee.addObserver(self, forKeyPath: "name", options: .old, context: &KVOContext)
        employee.addObserver(self, forKeyPath: "raise", options: .old, context: &KVOContext)
    }
    
    func removeObservingEmployee(employee: Employee){
        employee.removeObserver(self, forKeyPath: "name", context: &KVOContext)
        employee.removeObserver(self, forKeyPath: "raise", context: &KVOContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context != &KVOContext {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        let e = object as! Employee
        let oldValue: Any = change?[.oldKey] as Any
        undoManager?.registerUndo(withTarget: e){ target in
            Swift.print("undo set value \(oldValue) target=\(target) keyPath=\(keyPath)")
            target.setValue(oldValue, forKey: keyPath!)
        }
        undoManager?.setActionName("Change Employee")
    }
    
    // MARK: - NSWindowDelegate
    
    func windowWillClose(_ notification: Notification) {
        employees = []
    }
    
    @IBAction func addEmployee(_ sender: AnyObject) {
        let windowController = windowControllers[0]
        let window = windowController.window!
        
        let endedEditing = window.makeFirstResponder(window)
        if !endedEditing {
            Swift.print("Unable to end editing")
            return
        }
        
        let undo = undoManager!
        
        if undo.groupingLevel > 0 {
            undo.endUndoGrouping()
            undo.beginUndoGrouping()
        }
        
        let employee = arrayController.newObject() as! Employee
        arrayController.addObject(employee)
        arrayController.rearrangeObjects()
        
        let sortedEmployees = arrayController.arrangedObjects as! [Employee]
        let row = sortedEmployees.index(of: employee)!
        
        tableView.editColumn(0, row: row, with: nil, select: true)
    }
    
    @IBAction func removeEmployees(_ sender: NSButton){
        let selectedEmployees = arrayController.selectedObjects as! [Employee]
        
        let alert = NSAlert()
        alert.messageText = "Do you really want to remove these people?"
        alert.informativeText = "\(selectedEmployees.count) people will be removed."
        alert.addButton(withTitle: "Remove")
        alert.addButton(withTitle: "Cancel")
        
        let window = sender.window!
        alert.beginSheetModal(for: window, completionHandler: {response in
            switch response {
            case NSAlertFirstButtonReturn:
                self.arrayController.remove(nil)
            default: break
            }
        })
    }
    
    
    @IBAction func printV(_ sender: AnyObject) {
        Swift.print(v)
    }
    
    @IBAction func updateV(_ sender: AnyObject){
            if let target = undoManager?.prepare(withInvocationTarget: self) as? Document {
            Swift.print("add undo v=>\(v)")
            target.set(v: v)
            undoManager?.setActionName("dec v")
        }
       
        counter += 1
        v = counter
    }
    
    func set(v: Int){
        Swift.print("set v=>\(v)")
        self.v = v
    }
    
    
}

