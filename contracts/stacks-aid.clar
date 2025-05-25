;; StacksAid: Transparent Charity Platform
;;
;; A decentralized charity platform built on Stacks that enables transparent donations,
;; beneficiary management, and milestone-based fund utilization tracking.
;;
;; This contract implements:
;;  - Role-based access control
;;  - Beneficiary registration and management
;;  - Secure donation processing
;;  - Transparent fund utilization tracking
;;

;; Constants & Storage

;; Contract owner
(define-data-var contract-owner principal tx-sender)

;; Error constants
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-ALREADY-REGISTERED (err u101))
(define-constant ERR-NOT-FOUND (err u102))
(define-constant ERR-INSUFFICIENT-FUNDS (err u103))
(define-constant ERR-BENEFICIARY-NOT-FOUND (err u104))
(define-constant ERR-UTILIZATION-NOT-FOUND (err u105))
(define-constant ERR-INVALID-INPUT (err u106))

;; Role definitions
(define-constant ROLE-ADMIN u1)
(define-constant ROLE-MODERATOR u2)
(define-constant ROLE-BENEFICIARY u3)

;; Data Structures

;; User role mapping
(define-map roles
  { user: principal }
  { role: uint }
)

;; Beneficiary registry
(define-map beneficiaries
  { id: uint }
  {
    name: (string-utf8 50),
    description: (string-utf8 255),
    target-amount: uint,
    received-amount: uint,
    status: (string-ascii 20),
  }
)

;; Donation records
(define-map donations
  { id: uint }
  {
    donor: principal,
    beneficiary-id: uint,
    amount: uint,
    timestamp: uint,
  }
)